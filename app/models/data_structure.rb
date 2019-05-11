class DataStructure
  extend ActiveModel::Naming
  
  attr_accessor :data_items, :sprint_names, :projectName
 
  def initialize(data_items, sprint_names, project)
    @dataItems=data_items
    @namesOfSprints=sprint_names
    @projectName=project
  end
  
  def persisted?
    false
  end
end


