module ApplicationHelper

  # helper class to avoid escape json of BigDecimal
  class BigDecimal
    def as_json(options = nil) self end
    def encode_json(encoder) to_s end
  end

  def include_javascript(file)
      s = " <script type=\"text/javascript\">" + render(:file => file) + "</script>"
      content_for(:head, raw(s))
  end
  
  def show_menu(title, *items)
    render partial: "shared/show_menu", :locals => { :title => title, :items => items } 
  end
end
