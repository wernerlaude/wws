class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]

  def index
    @addresses = Address.order(:nummer).all
  end

  def show; end

  def new
    @address = Address.new
  end

  def edit; end

  def create
    @address = Address.new(address_params)
    if @address.save
      redirect_to @address, notice: "Adresse wurde erstellt."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @address.update(address_params)
      redirect_to @address, notice: "Adresse wurde aktualisiert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
    redirect_to addresses_url, notice: "Adresse wurde gelöscht."
  end

  private

  def set_address
    @address = Address.find(params[:id]) # primary_key = nummer
  end

  def address_params
    params.require(:address).permit(
      :nummer, :name1, :name2, :branche, :strasse, :plz, :ort, :land,
      :telefon1, :telefon2, :telefax, :email, :homepage, :art, :erledigt
    )
  end
end