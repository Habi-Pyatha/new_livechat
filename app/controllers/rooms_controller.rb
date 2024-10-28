class RoomsController < ApplicationController
  def index
    @current_user = current_user
    # redirect_to "/signin" unless @current_user
    unless @current_user
      redirect_to "/signin" and return # Redirect and stop further execution
    end
    @rooms = Room.public_rooms
    @users = User.all_except(@current_user)
    @room = Room.new
    render "index"
  end
  def create
    # @room = Room.create(name: params["room"]["name"])
    @room = Room.new(room_params)
    @room.is_private=false
    if @room.save
      redirect_to @room, notice: "Room was successfully created."
    else
      render "index"
    end
  end
    def show
      @current_user = current_user
      @single_room = Room.find(params[:id])
      @rooms = Room.public_rooms
      @users = User.all_except(@current_user)
      @room = Room.new
      @message = Message.new
      @messages = @single_room.messages

      render "index"
    end

  def room_params
    params.require(:room).permit(:name) # Add other permitted params as necessary
  end
end
