# app/controllers/customers_controller.rb
class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @customers = Customer.order(:kundennr).all
  end

  def show; end

  def new
    @customer = Customer.new
  end

  def edit; end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: "Kunde wurde erstellt."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Kunde wurde aktualisiert."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_url, notice: "Kunde wurde gelöscht."
  end

  private

  def set_customer
    @customer = Customer.find(params[:id]) # funktioniert mit custom primary_key (= kundennr)
  end

  # strong params mit deutschen Spalten
  def customer_params
    params.require(:customer).permit(
      :kundennr, :kundgruppe, :bundesland, :umsatzsteuer, :gekuendigt, :mitgliednr,
      :rabatt, :zahlungart, :fremdwaehrung, :datumeintritt, :datumaustritt
    )
  end
end