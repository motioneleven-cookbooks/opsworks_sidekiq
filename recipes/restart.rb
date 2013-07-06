node[:deploy].each do |application, deploy|
  execute 'restart sidekiq' do
    command '/usr/bin/god restart workers'
    environment({
      'PATH' => '/usr/local/bin:/usr/bin'
    })
    user 'root'
    action :nothing
  end

  ruby_block 'restart sidekiq later' do
    notifies :run, resources(:execute => 'restart sidekiq'), :delayed
  end
end
