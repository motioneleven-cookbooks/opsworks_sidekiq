node[:deploy].each do |application, deploy|
  bash 'stop sidekiq' do
    code <<-EOH
    /usr/bin/god stop workers
    EOH
    user 'root'
    action :run
  end
end
