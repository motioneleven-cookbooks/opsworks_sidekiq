node[:deploy].each do |application, deploy|
  bash 'restart sidekiq' do
    code <<-EOH
    /usr/bin/god restart workers
    EOH
    user 'root'
    action :run
  end
end
