class MyKeep
  def self.the_array
    @@the_array ||= Array.new
  end

  def self.add element
    if @@the_array
      @@the_array << element
    else
      @@the_array = [element]
    end
  end
end