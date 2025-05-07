class ReferenceDataController < ApplicationController
  before_action :set_reference_datum, only: %i[show update destroy]

  # GET /reference_data
  def index
    result = ReferenceDatum.filter(params[:data_type])
    render(json: result)
  end

  # GET /reference_data/1
  def show
    render(json: @reference_datum)
  end

  # POST /reference_data
  def create
    @reference_datum = ReferenceDatum.new(reference_datum_params)

    if @reference_datum.save
      render(json: @reference_datum, status: :created, location: @reference_datum)
    else
      render(json: @reference_datum.errors, status: :unprocessable_entity)
    end
  end

  # PATCH/PUT /reference_data/1
  def update
    if @reference_datum.update(reference_datum_params)
      render(json: @reference_datum)
    else
      render(json: @reference_datum.errors, status: :unprocessable_entity)
    end
  end

  # DELETE /reference_data/1
  def destroy
    @reference_datum.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reference_datum
    @reference_datum = ReferenceDatum.find(params[:id])
  end

  # Only allow a trusted parameter "allowlist" through.
  def reference_datum_params
    params.fetch(:reference_datum, {})
  end
end
