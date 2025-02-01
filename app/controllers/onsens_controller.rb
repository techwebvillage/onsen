class OnsensController < ApplicationController
  before_action :set_onsen, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @onsens = Onsen.includes(:reviews).order(created_at: :desc)
  end

  def show
    @reviews = @onsen.reviews.includes(:user)
  end

  def new
    @onsen = Onsen.new
  end

  def edit
  end

  def create
    @onsen = current_user.onsens.build(onsen_params)
    if @onsen.save
      redirect_to @onsen, notice: '温泉施設を登録しました'
    else
      render :new
    end
  end

  def update
    if @onsen.update(onsen_params)
      redirect_to @onsen, notice: '温泉施設を更新しました'
    else
      render :edit
    end
  end

  def destroy
    @onsen.destroy
    redirect_to onsens_path, notice: '温泉施設を削除しました'
  end

  private

  def set_onsen
    @onsen = Onsen.find(params[:id])
  end

  def authorize_user!
    unless @onsen.user == current_user
      redirect_to onsens_path, alert: '権限がありません'
    end
  end

  def onsen_params
    params.require(:onsen).permit(:name, :address, :description, :rating, :price, images: [])
  end
end 