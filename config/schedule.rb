set :output, "#{shared_path}/log/deleted_files.log"

every 1.day do
  command "find #{shared_path}/public/eyesoup/* -mtime +5 -exec rm {} \;"
end
