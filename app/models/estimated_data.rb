# This is the data structure that should be  forwarded to the estimated time riport view
class EstimatedData
  extend ActiveModel::Naming
  
  attr_accessor :date, :estimated_sum, :fact_sum, :left_sum
 
  def initialize(date, estimated_sum, fact_sum, left_sum)
    @date=date
    @estimatedSum=estimated_sum
    @factSum=fact_sum
    @leftSum=left_sum
  end
  
  def persisted?
    false
  end
end


