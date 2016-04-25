module Api
  module V1
    class TransactionController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :authenticate_with_token
      respond_to :json

      def create
        @transaction = Transaction.new(transaction_params)
        if @transaction.save
          render json: @transaction, status: 201, serializer: nil
        else
          render json: { 'status' => 'error', 'message' => @transaction.errors.full_messages }, status: 500
        end
      ensure
        clean_tempfile
      end

      private

      def current_client
        @current_client ||= Client.find_by(auth_token: params['access_token'])
      end

      def authenticate_with_token
        render json: { errors: 'Not Authenticated' },
               status: :unauthorized unless current_client.present?
      end

      def transaction_params
        allowed_params = params.require(:transaction).permit(:guest_transaction, :guest_user_id, :regular_user_id, :food_type, :price, :date, :image)
        allowed_params[:image] = parse_image_data(allowed_params[:image]) if allowed_params[:image]
        allowed_params
      end

      def parse_image_data(base64_image)
        filename = 'image'
        string = base64_image.split(/[:;,]/)[3]

        @tempfile = Tempfile.new(filename)
        @tempfile.binmode
        @tempfile.write Base64.decode64(string)
        @tempfile.rewind

        # for security we want the actual content type, not just what was passed in
        content_type = `file --mime -b #{@tempfile.path}`.split(';')[0]

        # we will also add the extension ourselves based on the above
        # if it's not gif/jpeg/png, it will fail the validation in the upload model
        extension = content_type.match(/gif|jpeg|png/).to_s
        filename += ".#{extension}" if extension

        ActionDispatch::Http::UploadedFile.new(
          tempfile: @tempfile,
          content_type: content_type,
          filename: filename
        )
      end

      def clean_tempfile
        return unless @tempfile
        @tempfile.close
        @tempfile.unlink
      end
    end
  end
end
