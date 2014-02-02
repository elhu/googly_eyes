env 'APP_PATH', '/home/app/googly_eyes/'

every 1.day, at: '4:00 am' do
  command "find $APP_PATH/public/eyesoup/* -mtime +5 -exec rm {} \;"
end
