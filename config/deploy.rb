# config valid for current version and patch releases of Capistrano
lock '~> 3.11.1'

set :application, 'EternalAlchemy'
set :repo_url, 'git@github.com:Eearslya/eternal-alchemy-backend.git'
set :deploy_to, '/home/eternalalchemy/EternalAlchemy'
set :keep_releases, 5
append :linked_files, 'config/master.key'
append :linked_dirs, 'log', 'tmp/sockets'

after 'deploy:publishing', 'puma:restart'
