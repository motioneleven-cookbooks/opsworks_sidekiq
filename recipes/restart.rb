node[:deploy].each do |application, deploy|
  execute 'restart sidekiq' do
    command '/usr/bin/god restart workers'
    environment({
      'PATH' => '/usr/local/bin:/usr/bin'
    })
    user 'root'
    action :run
  end
end
