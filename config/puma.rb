#!/usr/bin/env puma
# frozen_string_literal: true

threads 4, 32

basedir = '/home/eternalalchemy/EternalAlchemy/current'

directory "#{basedir}"
environment 'production'
daemonize true
pidfile "#{basedir}/tmp/sockets/puma.pid"
bind "unix://#{basedir}/tmp/sockets/puma.sock"
state_path "#{basedir}/tmp/sockets/puma.state"

preload_app!
activate_control_app
plugin :tmp_restart
