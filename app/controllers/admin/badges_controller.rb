class Admin::BadgesController < Admin::BaseController
  before_action :set_badge, only: %i[show edit destroy]

  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
  end

  def show; end

  def create
    @badge = Badge.new(badge_params)

    if @badge.save
      redirect_to admin_badges_path
    else
      render :new
    end
  end

  def update; end

  def destroy
    @badge.destroy
    redirect_to admin_badges_path
  end

  private

  def badge_params
    params.require(:badge).permit(:image_url, :name, :rule_type, :description, :value)
  end

  def set_badge
    @badge = Badge.find(params[:id])
  end

end
