class DataItem
  extend ActiveModel::Naming
  
  attr_accessor :user, :date, :sprints
 
  def initialize(user, date, sprints)
    @user=user
    @date=date
    @sprints=sprints
  end
  
  def persisted?
    false
  end
end


