bundle exec rake resque:workers QUEUE=* COUNT=10 BACKGROUND=yes >> log/resque.log 2>&1
