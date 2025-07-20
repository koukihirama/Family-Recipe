class FamiliesController < ApplicationController
  # 家族コード入力画面ではセッションチェックをスキップ
  skip_before_action :require_family_login, only: [ :new, :create ]

  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    @family.code = SecureRandom.hex(16)

    if @family.save
      session[:family_id] = @family.id
      cookies[:family_code] = { value: @family.code, expires: 1.month.from_now }
      redirect_to @family, notice: "家族を作成しました！この家族コードを家族に伝えてください。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def join
  @family = Family.find_by(code: params[:code])

  if @family
    session[:family_id] = @family.id
    redirect_to root_path, notice: "家族に参加しました！"
  else
    redirect_to family_login_path, alert: "無効な家族コードです"
  end
end

def regenerate_family_code
  @family = Family.find(params[:id])
  @family.update(code: SecureRandom.urlsafe_base64(15))
  redirect_to @family, notice: "家族コードを再発行しました。新しいコードをご確認ください。"
end

  def show
    @family = current_family
  end

  def login_form
    # 家族コード入力フォームを表示するだけ
  end

  def login
    family_code = params[:family_code]

    if Family.exists?(code: family_code)
      session[:family_code] = family_code
      redirect_to root_path, notice: "家族コードでログインしました"
    else
      flash.now[:alert] = "家族コードが間違っています"
      render :login_form
    end
  end

  def logout
    reset_session
    redirect_to family_login_path, notice: "ログアウトしました"
  end

  private

  def family_params
    params.require(:family).permit(:name)
  end
end
