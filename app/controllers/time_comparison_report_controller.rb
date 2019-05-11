class TimeComparisonReportController < ApplicationController
  def filter
    @project = Project.find(params[:id])
    @versions_selection = []

    @project.versions.each do |version|
      @versions_selection << [version.name, version.id]
    end

    @tracker = Tracker.all
    @trackers_selection = []

    @tracker.each do |tracker|
      @trackers_selection << [tracker.name, tracker.id]
    end
  end

  def get_sprints
    if params.key?(:versions)
      Version.find(params[:versions])
    else
      @project.versions
    end
  end

  def get_trackers
    if params.key?(:trackers)
      Tracker.find(params[:trackers])
    else
      @project.trackers.to_enum
    end
  end

  def get_start_date(sprints, trackers)
    Issue.where(project_id: @project.id)
        .where(fixed_version_id: sprints.map {|f| f.id})
        .where(tracked_id: trackers.map {|f| f.id})
        .order(:start_date).first.start_date
  end

  def report
    require 'date'
    @project = Project.find(params[:id])
    sprints = get_sprints
    trackers = get_trackers

    start_date = get_start_date(sprints, trackers)
    end_date = sprints.sort_by {|e| e[:due_date]}.reverse.first.due_date

    if end_date >= Date.today
      end_date = Date.today
    end

    #filtering
    issues = Issue.where("start_date>= :start AND start_date<= :end AND project_id= :p_id", {
        start: start_date,
        end: end_date,
        p_id: @project.id})
                 .where("estimated_hours is not null")
                 .where(tracker_id: trackers.map {|f| f.id})
                 .where(fixed_version_id: sprints.map {|f| f.id}
                 )

    data = get_data(start_date, end_date, issues)
      ###puts "#{@project.name} datum: #{newItem.date}, becsult: #{newItem.estimatedSum}, teny: #{newItem.factSum}, es... #{newItem.leftSum}"
    @dataToShow = DataStructure.new(data, sprints.map {|f| f.name}, @project.name)
  end

  def get_data(start_date, end_date, issues)
    spent_on_sum = 0
    data = []

    (start_date..end_date).each do |date|
      new_data = EstimatedData.new(date, 0, 0, 0)
      new_data.leftSum -= spent_on_sum

      issues.each do |issue|
        if !issue.closed_on || issue.closed_on >= date
          entries = TimeEntry.where("spent_on=:dd AND issue_id=:i_id", {
              dd: date,
              i_id: issue.id
          })
          spent_on_issue = 0
          entries.each do |entry|
            spent_on_issue += entry.hours
            new_data.factSum += entry.hours
          end
          new_data.estimatedSum += issue.estimated_hours
          new_data.leftSum += issue.estimated_hours - spent_on_issue
          spent_on_sum += spent_on_issue
        end
      end

      data << new_data
    end
  end
end
  