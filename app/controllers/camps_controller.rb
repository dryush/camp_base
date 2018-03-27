class CampsController < ApplicationController
  before_action :set_camp, only: [:show, :edit, :update, :destroy]

  # GET /camps
  # GET /camps.json
  def index
    if params[:city_id]
      @camps = City.find(params[:city_id]).camps.
          sort_by { |c| [c.city.region.country.name, c.city.region.name, c.city.name, c.name] }
    elsif params[:region_id]
      @camps = Camp.find_by_sql('SELECT camps.* FROM regions
	                                LEFT JOIN cities on cities.region_id = regions.id
                                  INNER JOIN camps on camps.city_id = cities.id
                                  WHERE regions.id =' + params[:region_id]).
                                  sort_by { |c| [c.city.region.country.name, c.city.region.name, c.city.name, c.name] }

=begin
      @camps = Region.where(region_id: params[:region_id]).left_joins(:cities).left_joins(:regions).select(:camp).jo
      region_id = params[:region_id].to_i
      region = Region.find(region_id)
      camps = []
      region.cities.each {|city|
        camps.append city.camps
      }
      @camps = camps
=end
    elsif params[:country_id]

      @camps = Camp.find_by_sql('SELECT camps.* FROM countries
                                  LEFT JOIN regions on regions.country_id = countries.id
                                  LEFT JOIN cities on cities.region_id = regions.id
                                  INNER JOIN camps on camps.city_id = cities.id
                                  WHERE countries.id=' + params[:country_id]).
                                  sort_by { |c| [c.city.region.country.name, c.city.region.name, c.city.name, c.name] }



    else
      @camps = Camp.all.sort_by { |c| [c.city.region.country.name, c.city.region.name, c.city.name, c.name] }
    end
  end

  # GET /camps/1
  # GET /camps/1.json
  def show
  end

  # GET /camps/new
  def new
    @camp = Camp.new
    @cities = City.all
  end

  # GET /camps/1/edit
  def edit
    @cities = City.all
  end

  # POST /camps
  # POST /camps.json
  def create
    @camp = Camp.new(camp_params)

    respond_to do |format|
      if @camp.save
        format.html { redirect_to @camp, notice: 'Camp was successfully created.' }
        format.json { render :show, status: :created, location: @camp }
      else
        format.html { render :new }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /camps/1
  # PATCH/PUT /camps/1.json
  def update
    respond_to do |format|
      if @camp.update(camp_params)
        format.html { redirect_to @camp, notice: 'Camp was successfully updated.' }
        format.json { render :show, status: :ok, location: @camp }
      else
        format.html { render :edit }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camps/1
  # DELETE /camps/1.json
  def destroy
    @camp.destroy
    respond_to do |format|
      format.html { redirect_to camps_url, notice: 'Camp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camp
      @camp = Camp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def camp_params
      params.require(:camp).permit(:name, :description, :city_id)
    end
end
