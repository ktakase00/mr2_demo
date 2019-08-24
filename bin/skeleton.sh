#!/bin/bash

RBENV_SHIMS_DIR=~/.anyenv/envs/rbenv/shims
WORK_DIR=~/rails
APPS_DIR=~/repo/apps
APP_NAME=web
DB_USER=mr2
DB_PASSWORD=mr2
DB_HOST=db
WDS_PORT=4035
RAILS_TIMEZONE=Tokyo

# railsをインストール
mkdir -p ${WORK_DIR}
cd ${WORK_DIR}
${RBENV_SHIMS_DIR}/bundle init
echo "
gem 'rails'
gem 'listen'
gem 'bootsnap'
gem 'webpacker'
" >> Gemfile
${RBENV_SHIMS_DIR}/bundle install --path=vendor/bundler

# 新しいプロジェクトを作成
${RBENV_SHIMS_DIR}/bundle exec rails new ${APP_NAME} \
  -d postgresql \
  --skip-coffee \
  --skip-turbolinks \
  --skip-test \
  -B \
  --webpack

# Gemfile編集
cd ${APP_NAME}
mv Gemfile Gemfile.org
sed -e "s/^\(gem 'jbuilder'\)/# \1/" Gemfile.org | \
  sed -e "s/\(gem 'byebug'.\+\)/\1\n  gem 'rspec-rails', '~> 3.8' \n  gem 'factory_bot_rails'/" \
  > Gemfile
echo "
gem 'rails-i18n', '~> 5.1'
gem 'http_accept_language'
" >> Gemfile
rm Gemfile.org

# package.json編集
yarn add foundation-sites jquery what-input

# database.yml編集
mv config/database.yml config/database.yml.org
sed -e "s/\(database: ${APP_NAME}_development\)/\1\n  username: ${DB_USER}\n  password: ${DB_PASSWORD}\n  host: ${DB_HOST}/" config/database.yml.org | \
  sed -e "s/\(database: ${APP_NAME}_test\)/\1\n  username: ${DB_USER}\n  password: ${DB_PASSWORD}\n  host: ${DB_HOST}/" \
  > config/database.yml
rm config/database.yml.org

# webpacker.yml編集
mv config/webpacker.yml config/webpacker.yml.org
sed -e "s/\(host:\) localhost/\1 0.0.0.0/" config/webpacker.yml.org | \
  sed -e "s/\(public: localhost\):3035/\1:${WDS_PORT}\n    sock_port: ${WDS_PORT}/" \
  > config/webpacker.yml
rm config/webpacker.yml.org

# application.rb編集
mv config/application.rb config/application.rb.org
sed -e "s/\(config.generators.system_tests = nil\)/\1\n\n    config.time_zone = '${RAILS_TIMEZONE}'\n    config.active_record.default_timezone = :local/" config/application.rb.org \
  > config/application.rb
rm config/application.rb.org

# locale.rb作成
echo "
I18n.available_locales = [:en, :ja]
I18n.default_locale = :en
" > config/initializers/locale.rb

# プロジェクトを保存
cd ${WORK_DIR}
rm -Rf ${APP_NAME}/node_modules
rm ${APP_NAME}/yarn.lock
mv ${APP_NAME} ${APPS_DIR}
