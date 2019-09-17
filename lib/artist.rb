class Artist
  attr_reader :id, :name, :born, :died, :country

  def initialize(details)
    @id = details[:id]
    @name = details[:name]
    @born = details[:born]
    @died = details[:died]
    @country = details[:country]
  end

end
