class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Transaction.accessible_by(current_ability).order('date DESC').ransack(params[:q])
    @transactions = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    @guest_users = GuestUser.accessible_by(current_ability)
    @regular_users = RegularUser.accessible_by(current_ability)

    respond_to do |format|
      format.html
      format.csv { send_data @transactions.to_csv, filename: "#{current_user.name}-logs.csv" }
      format.xls
      format.json { render json: @q.result(distinct: true), root: false}
    end
  end

  def edit
  end

  def update
    if @transaction.update_attributes(transaction_params)
      flash[:success] = 'Record updated successfully'
      redirect_to regular_user_transactions_path(regular_user_id: current_user.id)
    else
      render 'edit'
    end
  end

  def destroy
    @transaction.destroy
    flash[:success] = 'Deleted successfully'
    redirect_to regular_user_transactions_path(regular_user_id: current_user.id)
  end

  def getimage
    send_file @transaction.image.path, :x_sendfile=>true, disposition: 'inline'
  end

  private

  def transaction_params
    params.require(:transaction).permit(:price, :food_type, :date)
  end
end
