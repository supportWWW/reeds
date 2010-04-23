class DateTime
  def fmt_long
    strftime("%d %b %Y %H:%M")
  end
end

class Time
  def fmt_long
    strftime("%d %b %Y %H:%M")
  end
end

class Date
  def fmt_long
    strftime("%d %b %Y %H:%M")
  end
  def fmt_long_date
    strftime("%d %b %Y")
  end
end
