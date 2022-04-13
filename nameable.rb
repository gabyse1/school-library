class Nameable
  def correct_name
    raise NoImplementedError, "#{self.class} has not implmemented method"
  end
end