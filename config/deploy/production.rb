server '3.113.172.11', user: 'ec2-user', roles: %w{app db web}
set :rails_env, "production"
set :unicorn_rack_env, "production"
