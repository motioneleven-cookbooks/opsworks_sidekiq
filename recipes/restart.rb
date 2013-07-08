node[:deploy].each do |application, deploy|
  bash 'restart sidekiq' do
    code <<-EOH
    sleep 1
    /usr/bin/god restart workers
    EOH
    user 'root'
    action :run
  end
end
