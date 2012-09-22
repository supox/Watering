module DateTimeHelper
  def to_time(t)
    begin
      if t.is_a?(Time)
        return t
      elsif t.is_a?(Integer)
        return Time.at(t)
      elsif(t.is_a?(String))
        return Time.parse(t)
      end
    rescue Exception => e
    end
    return nil
  end
end
