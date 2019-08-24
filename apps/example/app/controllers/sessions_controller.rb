class SessionsController < ApplicationController
  before_action :validate_session_form, only: [ :create ]
  before_action :authenticate, only: [ :create ]

  # GET /sessions/new
  def new
    @session_form = SessionForm.new
  end

  # POST /sessions
  def create
    session[:user_id] = @user.id
    redirect_to reservations_path
  end

  # DELETE /sessions/1
  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end

  private
    def create_params
      params.require(:session_form).permit(:user_cd)
    end

    def validate_session_form
      @session_form = SessionForm.new(create_params)
      render :new if @session_form.invalid?
    end

    def authenticate
      @user = User.find_by({ user_cd: @session_form.user_cd })
      return if @user.present?

      @session_form.errors.add(:base, I18n.t('view.session.failed_to_authenticate'))
      render :new
    end
end
