CalendarPrintableData = Struct.new(:title, :description, :from, :to) do

  def self.from_hash(attributes)
    instance = self.new
    attributes.each do |key, value|
      instance[key] = value
    end
    instance
  end

end