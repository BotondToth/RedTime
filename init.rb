require 'redmine'

Redmine::Plugin.register :redtime do
  name 'RedTime plugin'
  author 'Redmine fejlesztés csapat'
  description 'Idővizualizáló plugin redmine rendszerhez'
  version '0.0.3'
  permission :view_redtime_menu, :redtime => :index, :public => true
  menu :project_menu, :view_redtime_menu,{ :controller => 'redtime', :action => 'index' }, {:caption => 'Redtime', :last => true}
  menu :project_menu, :view_redtime_menu_2,{ :controller => 'time_report', :action => 'report' }, {:caption => 'TimeReport', :last => true}
end
