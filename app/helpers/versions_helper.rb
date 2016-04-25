module VersionsHelper
  def transaction_change_desc(event, actor_id)
    if event == 'update'
      "#{actor(actor_id)} updated a transaction"
    elsif event == 'create'
      "#{actor(actor_id)} logged a new transaction"
    elsif event == 'destroy'
      "#{actor(actor_id)} deleted a transaction"
    end
  end

  def guest_change_desc(event, actor_id)
    if event == 'update'
      "#{actor(actor_id)} updated a Guest booking"

    elsif event == 'create'
      "#{actor(actor_id)} booked a new guest."

    elsif event == 'destroy'
      "#{actor(actor_id)} deleted a Guest booking"
    end
  end

  def user_change_desc(user_id, event, actor_id)
    if event == 'update'
      "#{actor(actor_id)} updated #{actor(user_id)}'s  profile"
    elsif event == 'create'
      "#{actor(user_id)} signed up"
    elsif event == 'destroy'
      "#{actor(actor_id)} deleted a #{actor(user_id)}'s account"
    end
  end

  def actor(actor_id)
    if actor_id.nil?
      'System'
    elsif RegularUser.where(id: actor_id).empty?
      'Deleted User'
    else
      RegularUser.find(actor_id).name
    end
  end
end
