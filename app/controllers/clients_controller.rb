class ClientsController < ApplicationController
  load_and_authorize_resource

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = 'Client was successfully registered'
      redirect_to clients_path
    else
      render :new
    end
  end

  def update
    if @client.update(client_params)
      flash[:success] = 'Client was successfully updated'
      redirect_to clients_path
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    flash[:success] = 'Client was successfully destroyed'
    redirect_to clients_path
  end

  private

  def client_params
    params.require(:client).permit(:name, :password)
  end
end
