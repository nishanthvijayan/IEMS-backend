module RegularUsersHelper
  def full_food_type(short_food_type)
    case short_food_type
    when 'B'
      'Breakfast'
    when 'L'
      'Lunch'
    when 'D'
      'Dinner'
    when 'S'
      'Special'
    end
  end
end
