node[:deploy].each do |application, deploy|
  execute 'restart sidekiq' do
    cwd deploy[:current_path]
    command '/usr/bin/god restart workers'
    environment({
      'PATH' => '/usr/local/bin'
    })
    user 'root'
    action :run
  end
end
