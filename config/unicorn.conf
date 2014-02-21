# unicron.conf

worker_processes  4

application = 'r4'
working_directory '/var/www/projects/r4/current'
listen "/tmp/#{application}.sock", :backlog => 1
listen 4423, :tcp_nopush => true
timeout 10
pid "/tmp/#{application}.sock"
preload_app  true
stderr_path "/var/log/#{application}.log"

before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  sleep 1
end

after_fork do |server, worker|
  addr = "127.0.0.1:#{4424 + worker.nr}"
  server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => 1)
  # disconnection db 
  dbconfig = ActiveRecord::Base.remove_connection
  # re-establish db connection 
  ActiveRecord::Base.establish_connection(dbconfig)
end