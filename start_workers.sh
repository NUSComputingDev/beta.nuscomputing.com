echo 'starting three workers'
nohup bundle exec rake resque:work QUEUE=* BACKGROUND=yes &
nohup bundle exec rake resque:work QUEUE=* BACKGROUND=yes &
nohup bundle exec rake resque:work QUEUE=* BACKGROUND=yes &
