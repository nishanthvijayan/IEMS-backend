module RegularUsersHelper

def full_food_type(short_food_type)
  if short_food_type == "B"
    return "Breakfast"
  elsif short_food_type == "L"
      return "Lunch"
  elsif short_food_type == "D"
      return "Dinner"
  else
    return "Special"
  end
end

end
