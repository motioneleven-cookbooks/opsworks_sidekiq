#
# Cookbook Name:: opsworks_sidekiq
# Recipe:: default
#
node[:deploy].each do |application, deploy|
  pid_file = File.join(deploy[:deploy_to], 'shared', 'pids', 'sidekiq.pid')
  god_monitor 'sidekiq' do
    template_cookbook 'god'
    template_source 'god_monitor.erb'
    variables({
      :name => 'sidekiq',
      :group => 'workers',
      :env => {'RAILS_ENV' => deploy[:rails_env]},
      :add_to_path => "/usr/local/bin",
      :uid => deploy[:user],
      :dir => File.join(deploy[:deploy_to], 'current'),
      :start => "cd #{File.join(deploy[:deploy_to], 'current')}; bundle exec sidekiq -e #{deploy[:rails_env]} -P #{pid_file} 2>&1 | logger -t sidekiq",
      :stop => "cd #{File.join(deploy[:deploy_to], 'current')}; bundle exec sidekiqctl stop #{pid_file} 60",
      :memory_max => (1434 * 1024)
    })
  end
end
