class TransactionsController < ApplicationController
  load_and_authorize_resource

  def index
    @q = Transaction.accessible_by(current_ability).ransack(params[:q])
    @transactions = @q.result(distinct: true).paginate(page: params[:page], per_page: 10)
    @guest_users = GuestUser.accessible_by(current_ability)
    @regular_users = RegularUser.accessible_by(current_ability)

    respond_to do |format|
      format.html
      format.csv { send_data @transactions.to_csv, filename: "#{current_user.name}-logs.csv" }
      format.xls
    end
  end
end
