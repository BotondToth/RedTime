get '/redtime/timereport/filter', to: 'time_report#filter'
get '/redtime/timereport/report', to: 'time_report#report'
get '/redtime/index', to: 'redtime#index', as: 'timevisualizer'
