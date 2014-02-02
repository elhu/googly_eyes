env 'APP_PATH', '/home/app/googly-eyes/current'

every 1.day, at: '4:00 am' do
  command "find $APP_PATH/public/eyesoup/* -mtime +1 -exec rm {} \\;"
end
