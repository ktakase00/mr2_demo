class ReservationsController < LoggedInController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :prepare_meeting_room_options, only: [ :new, :edit, :create, :update ]

  # GET /reservations
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  def show
    @atendded_user_ary = @reservation.reservation_users.eager_load(:user).where({
      attendance_flag: true
    })
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new_instance
    build_reservation_users
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)

    begin
      if @reservation.save
        redirect_to @reservation, notice: Util.flash_notice(:reservation, :create)
        return
      end
    rescue => e
      logger.error e.full_message
      flash[:alert] = Util.flash_alert(:reservation, :create)
    end
    render :new
  end

  # PATCH/PUT /reservations/1
  def update
    begin
      if @reservation.update(reservation_params)
        redirect_to @reservation, notice: Util.flash_notice(:reservation, :update)
        return
      end
    rescue => e
      logger.error e.full_message
      flash[:alert] = Util.flash_alert(:reservation, :update)
    end
    render :edit
  end

  # DELETE /reservations/1
  def destroy
    options = nil
    begin
      @reservation.destroy
      options = { notice: Util.flash_notice(:reservation, :destroy) }
    rescue => e
      logger.error e.full_message
      options = { alert: Util.flash_alert(:reservation, :destroy) }
    end
    redirect_to reservations_path, options
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reservation_params
      params.require(:reservation).permit(
        :title,
        :meeting_room_id,
        :start_at,
        :end_at,
        :memo_content,
        :reservation_users_attributes => [ :id, :reservation_id, :user_id, :attendance_flag ]
      ).merge({ user_id: @me.id })
    end

    def build_reservation_users
      others = User.where.not({ id: @me.id })
      @reservation.reservation_users_attributes = others.map { |it| { user_id: it.id } }
    end

    def prepare_meeting_room_options
      @meeting_room_options = MeetingRoom.all.map { |it|
        [ it.meeting_room_nm, it.id ]
      }.unshift(['', 0])
    end
end
