
class NilClass

  # stripping a nil object returns a blank string
  def strip
    ''
  end
  
end

class Numeric
  def roundup(nearest=10)
    self % nearest == 0 ? self : self + nearest - (self % nearest)
  end
  def rounddown(nearest=10)
    self % nearest == 0 ? self : self - (self % nearest)
  end
end 
