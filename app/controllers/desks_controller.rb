class DesksController < ApplicationController
  before_action :set_desk, only: [:show, :edit, :update, :destroy]

  # GET /desks
  # GET /desks.json
  def index
    @desks = Desk.all
  end

  # GET /desks/1
  # GET /desks/1.json
  def show
  end

  # GET /desks/new
  def new
    @slots = Slot.where(status: true)
    @desk = Desk.new
  end

  # GET /desks/1/edit
  def edit
  end

  def my_bookings
    @bookings = Desk.where(email: current_user.email)
    respond_to do |format|
      format.html { render :my_bookings}
    end
  end

  def cancel
    @booking = Desk.find(params[:id])
    @slot = Slot.where(name: @booking.desk).first
    @slot.update_attribute(:status, true)
    @booking.destroy
    redirect_to desks_path
  end

  # POST /desks
  # POST /desks.json
  def create
    @desk = Desk.new(desk_params)

    respond_to do |format|
      if @desk.save
        @slot = Slot.where(name: @desk.desk).first
        @slot.update_attribute(:status, false)
        format.html { redirect_to @desk, notice: 'Desk was successfully created.' }
        format.json { render :show, status: :created, location: @desk }
      else
        format.html { render :new }
        format.json { render json: @desk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /desks/1
  # PATCH/PUT /desks/1.json
  def update
    respond_to do |format|
      if @desk.update(desk_params)
        format.html { redirect_to @desk, notice: 'Desk was successfully updated.' }
        format.json { render :show, status: :ok, location: @desk }
      else
        format.html { render :edit }
        format.json { render json: @desk.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /desks/1
  # DELETE /desks/1.json
  def destroy
    @desk.destroy
    respond_to do |format|
      format.html { redirect_to desks_url, notice: 'Desk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_desk
      @desk = Desk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def desk_params
      params.require(:desk).permit(:user_name, :desk, :from_date, :to_date, :status, :email)
    end
end
