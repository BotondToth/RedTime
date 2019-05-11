# A plugin mukodesenek fo controllere
# minden kalkulaciot a lenti fuggvenyek vegeznek
class RedtimeController < ApplicationController

  def index
    @project = Project.find(params[:id])
    @sprints_selection, @trackers_selection, @sprints, @trackers = [], [], [], []
    get_sprints_selection
    get_trackers_selection
    get_sprints
    get_trackers
    calculate_graph
  end

  #relevans sprintek kivalasztasa
  def get_sprints
    if params.key?(:sprints)
      @sprints = Version.where(id: params[:sprints]).order(:created_on)
    else
      @sprints = @project.versions.order(:created_on)
    end
  end

  #szukseges trackerek kivalasztasa
  def get_trackers
    if (params.key?(:trackers))
      @trackers = Tracker.find(params[:trackers])
    else
      @trackers = @project.trackers
    end
  end

  #sprintek nevenek es id-jenek kiszurese
  def get_sprints_selection
    @project.versions.each do |version|
      @sprints_selection << [version.name, version.id]
    end
    @sprints_selection.sort
  end

  #trackerek nevenek es id-jenek kiszurese
  def get_trackers_selection
    @project.trackers.each do |tracker|
      @trackers_selection << [tracker.name, tracker.id]
    end
  end

  #heti ossz munkaorak kiszamolasa
  def get_work_hours_per_week
    work_hours_per_week = 0
    @project.members.each do |member|
      work_hours_per_week += member.user.custom_field_value(UserCustomField.find_by(name: "Munkaóra/Hét").id).to_i
    end
    work_hours_per_week
  end

  def get_journals_by_issue(journals, issue, date)
    issue_journals = []
    journals.where(journalized: issue).each do |journal|
      if (journal.created_on == date)
        issue_journals << journal
      end
    end
  end

  # @dataItems feltoltese valós adatokkal
  def calculate_graph
    @dataItems = []

    issues = Issue.where(fixed_version: @sprints, tracker: @trackers)
    time_entries = TimeEntry.where(issue: issues).order(:created_on) || []
    journals = Journal.where(journalized: issues).order(:created_on) || []
    journal_details = JournalDetail.where(journal: journals) || []
    work_hour_per_week = get_work_hours_per_week
    issue_hours = 0
    start_date = @sprints.first.created_on.to_date
    end_date = @sprints.last.effective_date.to_date
    added_issues = []
    added_time_entries = []
    added_journals = []

    (start_date..end_date).each do |date|
      work_days = (end_date - date).to_f
      issues.each do |issue|
        issue_journals = get_journals_by_issue(journals, issue, date)
        issue_journal_details = journal_details.where(journal: issue_journals, prop_key: "fixed_version_id", value: @sprints.ids)

        if !issue_journal_details.empty? || issue.created_on.to_date == date
          if !added_issues.find {|is| is[:issue] == issue}.present?
            added_issues << {:issue => issue, :time_left => issue.estimated_hours, :finished => false}
            issue_hours += issue.estimated_hours || 0
          end
          time_entries.where(issue: issue).each do |te|
            if !added_time_entries.include?(te) && te.spent_on <= date && !added_issues.find {|is| is[:issue] == issue}[:finished]
              added_time_entries << te
              if !issue.estimated_hours.nil?
                issue_hours -= te.hours
                added_issues.find {|is| is[:issue] == issue}[:time_left] -= te.hours
              end
            end
          end
        end
        if !journals.empty?
          journals.where(journalized: issue).each do |jo|
            if !added_journals.include?(jo) && jo.created_on.to_date == date && !journal_details.where(journal: jo, prop_key: "status_id", old_value: %w[1 2], value: %w[3 4 5 6]).empty? &&
                ((time = added_issues.find {|is| is[:issue] == issue}[:time_left]).nil? ? time = 0 : time > 0)
              added_journals << jo
              issue_hours -= time
              added_issues.find {|is| is[:issue] == issue}[:finished] = true
            elsif !added_journals.include?(jo) && jo.created_on.to_date == date && !journal_details.where(journal: jo, prop_key: "status_id", old_value: %w[3 4 5 6], value: %w[1 2]).empty? &&
                ((time = added_issues.find {|is| is[:issue] == issue}[:time_left]).nil? ? time = 0 : time > 0)
              added_journals << jo
              issue_hours += time
              added_issues.find {|is| is[:issue] == issue}[:finished] = false
            end
          end
        end
      end
      @dataItems << StatItem.new(1, "valami", {date => {:remaining_work_hour => ((work_days / 7.0) * work_hour_per_week).to_i, :remaining_issue_hour => issue_hours}})
    end
  end

end