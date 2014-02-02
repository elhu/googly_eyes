every 1.day, at: '4:00 am' do
  command "find #{shared_path}/public/eyesoup/* -mtime +5 -exec rm {} \;"
end
