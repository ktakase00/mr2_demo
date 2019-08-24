# memo

## ベースのDockerイメージ作成

```sh
cd base
docker build -t ktakase00/rubypg-learn:uv-201907 -f Dockerfile.base .
```

## MR2用Dockerイメージ作成

```sh
docker build -t ktakase00/rubypg-learn-mr2:uv-201908 .
```

## Railsプロジェクトの雛形作成

```sh
docker run --rm -v "$(pwd)":/home/ubuntu/repo ktakase00/rubypg-learn:uv-201907 /home/ubuntu/repo/bin/skeleton.sh
docker run --rm -v "$(pwd)":/home/ubuntu/repo ktakase00/rubypg-learn-mr2:uv-201908 /home/ubuntu/repo/bin/lock.sh
```

## scaffold

```sh
bundle exec rails generate scaffold User mail:text user_nm:text
bundle exec rails generate scaffold_controller Session
bundle exec rails generate scaffold MeetingRoom meeting_room_nm:text memo_content:text
bundle exec rails generate scaffold Reservation title:text user_id:bigint meeting_room_id:bigint start_at:timestamptz end_at:timestamptz memo_content:text
bundle exec rails generate model ReservationUser reservation_id:bigint user_id:bigint attendance_flag:boolean
```
