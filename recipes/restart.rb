node[:deploy].each do |application, deploy|
  execute 'restart sidekiq' do
    command 'sleep 1; /usr/bin/god restart workers'
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
    notifies :run, resources(:execute => 'restart sidekiq'), :delayed
  end
end
