class MembersController < ApplicationController
  before_action :set_family

  def new
    @member = @family.members.build
  end

  def create
    @member = @family.members.build(member_params)
    if @member.save
      redirect_to family_path(@family), notice: "メンバーを追加しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_family
    @family = Family.find(params[:family_id])
  end

  def member_params
    params.require(:member).permit(:name)
  end
end
