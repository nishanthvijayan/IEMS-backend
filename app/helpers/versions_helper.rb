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

  def guest_change_desc(guest_id, event, actor_id)
    if event == 'update'
      "#{actor(actor_id)} updated a Guest booking"

    elsif event == 'create'
      "#{actor(actor_id)} booked a new guest.
      ( #{GuestUser.find(guest_id).name} from
      #{GuestUser.find(guest_id).from_date.strftime('%a %d %B, %Y')} till #{GuestUser.find(guest_id).to_date.strftime('%a %d %B, %Y')} )"

    elsif event == 'destroy'
      "#{actor(actor_id)} deleted a Guest booking"
    end
  end

  def user_change_desc(user_id, event, actor_id)
    if event == 'update'
      "#{actor(actor_id)} updated #{RegularUser.find(user_id).name}'s  profile"
    elsif event == 'create'
      "#{RegularUser.find(user_id).name} signed up"
    elsif event == 'destroy'
      "#{actor(actor_id)} deleted a #{RegularUser.find(user_id).name}'s account"
    end
  end

  def actor(actor_id)
    if actor_id.nil?
      'System'
    else
      RegularUser.find(actor_id).name
    end
  end
end
