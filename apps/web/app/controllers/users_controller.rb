class UsersController < LoggedInController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    begin
      if @user.save
        redirect_to @user, notice: Util.flash_notice(:user, :create)
        return
      end
    rescue => e
      logger.error e.full_message
      flash[:alert] = Util.flash_alert(:user, :create)
    end
    render :new
  end

  # PATCH/PUT /users/1
  def update
    begin
      if @user.update(user_params)
        redirect_to @user, notice: Util.flash_notice(:user, :update)
        return
      end
    rescue => e
      logger.error e.full_message
      flash[:alert] = Util.flash_alert(:user, :update)
    end
    render :edit
  end

  # DELETE /users/1
  def destroy
    options = nil
    begin
      @user.destroy
      options = { notice: Util.flash_notice(:user, :destroy) }
    rescue => e
      logger.error e.full_message
      options = { alert: Util.flash_alert(:user, :destroy) }
    end
    redirect_to users_path, options
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:user_cd, :user_nm)
    end
end
