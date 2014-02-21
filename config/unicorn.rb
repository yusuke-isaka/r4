# unicron.conf

worker_processes  4

app_path = '/var/www/projects/r4'
app_shared_path = "#{app_path}/shared"
working_directory "#{app_path}/current/"

listen "#{app_shared_path}/tmp/sockets/unicorn.sock"
stdout_path "#{app_shared_path}/log/unicorn.stdout.log"
stderr_path "#{app_shared_path}/log/unicorn.stderr.log"
pid "#{app_shared_path}/tmp/pids/unicorn.pid"

preload_app true
listen 4423, :tcp_nopush => true

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