=begin
  A diagramhoz szukseges adatok strukturaja.
  @date: A vizsgalt idopont/datum
  @remaining_work_hours: Az adott @date idejen hatralevo munkaorak szama
  @remaining_issue_hours: Az adott @date idejen hatralevo feladatokra szant orak szama
=end

class StatItem
  extend ActiveModel::Naming

  attr_accessor :sprint, :type, :remaining_hours, :remaining_free_hours
 
  def initialize(sprint, type, remaining_hours)
    @sprint = sprint
    @type = type
    @remaining_hours = remaining_hours
    # remaining_work_hour = remaining_hours.map{|i, k| k[:remaining_work_hour]}[0]
    # remaining_issue_hour = remaining_hours.map{|i, k| k[:remaining_issue_hour]}[0]
    # remaining_free_hours = remaining_work_hour-remaining_issue_hour
    # @remaining_free_hours = remaining_free_hours
  end
  
  def persisted?
    false
  end

end
