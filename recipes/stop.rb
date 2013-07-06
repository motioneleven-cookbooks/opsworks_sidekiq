node[:deploy].each do |application, deploy|
  execute 'stop sidekiq' do
    command '/usr/bin/god stop workers'
    environment({
      'PATH' => '/usr/local/bin:/usr/bin'
    })
    user 'root'
    action :run
  end
end
