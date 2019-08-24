namespace :mr2 do
  desc "create a database"
  task createdb: :environment do
    db_config = Rails.application.config.database_configuration[Rails.env.to_s].symbolize_keys

    database_nm = db_config[:database]
    connect_str = "-h #{db_config[:host]} -U #{db_config[:username]}"
    env_str = "ON_ERROR_STOP=1"
    sql = "SELECT datname FROM pg_database LIMIT 1"

    # SQLを1つなんでもいいので実行してみる
    system %Q(psql #{connect_str} -v "#{env_str}" -c "#{sql}" #{database_nm} > /dev/null 2>&1)

    # exitstatusはSQLが成功すれば0、失敗すると2になる
    if $?.exitstatus != 0
      system "createdb #{connect_str} -E utf-8 -T template0 #{database_nm}"
    end
  end

end
