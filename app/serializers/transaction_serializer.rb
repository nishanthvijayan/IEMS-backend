class TransactionSerializer < ActiveModel::Serializer
  attributes :date, :guest_transaction, :food_type

  def date
    object.date.to_time.to_i
  end
end
