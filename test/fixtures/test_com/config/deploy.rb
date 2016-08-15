ENV["SPOT_MODE"] = "console"

require File.expand_path("../boot.rb", __FILE__)

require "spontaneous/capistrano"
require "bundler/capistrano"

default_run_options[:pty]   = true
# run capistrano in a login shell so that ruby version managers can do their thing
# otherwise it's just a constant problem trying to use the installed/configured
# version of ruby
default_run_options[:shell] = '/bin/bash -l'


ssh_options[:port]          = 22
ssh_options[:forward_agent] = true

set :ruby_version,          "2.3.0-p0"

set :domain,                "test.com"
set :cms,                   "edit.test.com"
set :application,           "test.com"
server                      "test.com", :app, :web, :db, :media
set :user,                  "test"
set :use_sudo,              false


set :scm,                   "git"
set :repository,            "git@test.com:spontaneous.git"

set :deploy_to,             "/home/#{fetch(:user)}/spontaneous"

namespace :deploy do
  task :restart, :roles => [:app, :web] do
    run "sv kill /home/#{fetch(:user)}/service/enabled/back"
  end
end
