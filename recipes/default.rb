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
      :env => {'RAILS_ENV' => 'production'},
      :start_command => "cd #{File.join(deploy[:deploy_to], 'current')}; bundle exec sidekiq -d -P #{pid_file}",
      :stop_command => "cd #{File.join(deploy[:deploy_to], 'current')}; bundle exec sidekiqctl stop #{pid_file} 60",
      :pid_file => pid_file,
      :memory_max => 1434.megabytes,
    })
  end
end
