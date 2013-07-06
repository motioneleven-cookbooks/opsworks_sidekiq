node[:deploy].each do |application, deploy|
  bash 'restart sidekiq' do
    code <<-EOH
    sleep 1
    /usr/bin/god restart workers
    EOH
    environment({
      'PATH' => '/usr/local/bin:/usr/bin'
    })
    user 'root'
    action :nothing
  end

  ruby_block 'restart sidekiq later' do
    block do
      true
    end
    notifies :run, resources(:bash => 'restart sidekiq'), :delayed
  end
end
