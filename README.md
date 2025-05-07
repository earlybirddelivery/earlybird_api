# Initial SetUp

`rbenv install 2.7.3`

`rbenv local 2.7.3`

`gem install bundler --version=2.2.8`

`bundle install`

configure the db passwords and usernames in database.yml if required

  if you get error like this 

  `PG::ConnectionBad: FATAL:  password authentication failed for user "postgres"`

  run `sudo -u user_name psql`

  and inside psql `ALTER USER user_name WITH PASSWORD 'new_password';

`rails db:create`

`rails db:migrate`

`rails db:seed`

`rails s`
