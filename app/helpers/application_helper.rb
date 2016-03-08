module ApplicationHelper

  def tick_or_cancel(condition)
    if condition
      content_tag :span, "", class: "glyphicon glyphicon-ok text-success pull-right" 
    else
      content_tag :span, "", class: "glyphicon glyphicon-remove text-danger pull-right"
    end
  end

end
