class AppmapsController < ApplicationController
  before_action :set_appmap, only: %i[ show edit update destroy ]

  # GET /appmaps or /appmaps.json
  def index
    @appmaps = Appmap.all

    # event = Event.new("./tmp/chart-dataset-small/following-followers-page.json")
    # visualizer = Visualizer.new(event.events)

    # @appmap = {
    #   "app/controllers": visualizer.controllers.count,
    #   "app/helpers": visualizer.helpers.count,
    #   "app/models": visualizer.models.count,
    # }
  end

  # GET /appmaps/1 or /appmaps/1.json
  def show
    event = Event.new(@appmap.path)
    visualizer = Visualizer.new(event.events)

    @visualizer = {
      "app/controllers": visualizer.controllers.count,
      "app/helpers": visualizer.helpers.count,
      "app/models": visualizer.models.count,
    }
  end

  # GET /appmaps/new
  def new
    @appmap = Appmap.new
  end

  # GET /appmaps/1/edit
  def edit
  end

  # POST /appmaps or /appmaps.json
  def create
    @appmap = Appmap.new(appmap_params)

    respond_to do |format|
      if @appmap.save
        format.html { redirect_to appmap_url(@appmap), notice: "Appmap was successfully created." }
        format.json { render :show, status: :created, location: @appmap }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appmap.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appmaps/1 or /appmaps/1.json
  def update
    respond_to do |format|
      if @appmap.update(appmap_params)
        format.html { redirect_to appmap_url(@appmap), notice: "Appmap was successfully updated." }
        format.json { render :show, status: :ok, location: @appmap }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appmap.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appmaps/1 or /appmaps/1.json
  def destroy
    @appmap.destroy

    respond_to do |format|
      format.html { redirect_to appmaps_url, notice: "Appmap was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appmap
      @appmap = Appmap.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appmap_params
      params.require(:appmap).permit(:path)
    end
end
