node[:deploy].each do |application, deploy|
  execute 'stop sidekiq' do
    cwd deploy[:current_path]
    command '/usr/bin/god stop workers'
    environment({
      'PATH' => '/usr/local/bin'
    })
    user 'root'
    action :run
  end
end
