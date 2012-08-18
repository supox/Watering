module CalendarHelper
  # show a calendar
  # Expected input : calendar_data is an array of hash with keys :date and :name with optional :url field.
  def show_calendar( calendar_data )
    if(!@has_put_calendar_head)
     content_for(:head, javascript_include_tag("fullcalendar.min.js"))
     content_for(:head, stylesheet_link_tag("fullcalendar.css"))
     @has_put_calendar_head = true;
    end
    render 'shared/calendar', data: calendar_data
  end
end
