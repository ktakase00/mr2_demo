class MeetingRoomsController < LoggedInController
  before_action :set_meeting_room, only: [:show, :edit, :update, :destroy]

  # GET /meeting_rooms
  def index
    @meeting_rooms = MeetingRoom.all
  end

  # GET /meeting_rooms/1
  def show
  end

  # GET /meeting_rooms/new
  def new
    @meeting_room = MeetingRoom.new
  end

  # GET /meeting_rooms/1/edit
  def edit
  end

  # POST /meeting_rooms
  def create
    @meeting_room = MeetingRoom.new(meeting_room_params)

    begin
      if @meeting_room.save
        redirect_to @meeting_room, notice: Util.flash_notice(:meeting_room, :create)
        return
      end
    rescue  => e
      logger.error e.full_message
      flash[:alert] = Util.flash_alert(:meeting_room, :create)
    end
    render :new
  end

  # PATCH/PUT /meeting_rooms/1
  def update
    begin
      if @meeting_room.update(meeting_room_params)
        redirect_to @meeting_room, notice: Util.flash_notice(:meeting_room, :update)
        return
      end
    rescue => e
      logger.error e.full_message
      flash[:alert] = Util.flash_alert(:meeting_room, :update)
    end
    render :edit
  end

  # DELETE /meeting_rooms/1
  def destroy
    options = nil
    begin
      @meeting_room.destroy
      options = { notice: Util.flash_notice(:meeting_room, :destroy) }
    rescue => e
      logger.error e.full_message
      options = { alert: Util.flash_alert(:meeting_room, :destroy) }
    end
    redirect_to meeting_rooms_path, options
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting_room
      @meeting_room = MeetingRoom.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def meeting_room_params
      params.require(:meeting_room).permit(:meeting_room_nm, :memo_content)
    end
end
