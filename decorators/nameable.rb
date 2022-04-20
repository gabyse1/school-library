class Nameable
  def correct_name
    raise NoImplementedError, "#{self.class} has not implemented method"
  end
end
