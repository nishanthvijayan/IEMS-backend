module Api
  module V1
    class TransactionController < ApplicationController
      respond_to :json
      def create
        @transaction = Transaction.new(transaction_params)
        if @transaction.save
          render json: @transaction, status: 201
        else
          render json: { 'status' => 'error', 'message' => @transaction.errors.full_messages }, status: 500
        end
      end

      private

      def transaction_params
        params.require(:transaction).permit(:guest_transaction, :guest_user_id, :regular_user_id, :food_type, :price, :date)
      end
    end
  end
end
