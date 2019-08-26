# MR2

## 実習内容

会議室予約の新規登録ができるようにしてください。
詳細は[こちら](https://qiita.com/kagesumi3m/private/10244978273ffffa9b92)を参照。

## サンプルプログラムについて

### 概要

サンプルプログラムMR2(Meeting Room Reservation)は、会議室予約をするWebアプリケーションです。

* 以下のリソースを管理する機能があります。
  * ユーザ
  * 会議室
  * 予約
* 各リソースについて、以下の画面があります。
  * 一覧
  * 新規登録
  * 編集
  * 詳細
* 各リソースの編集と削除は、詳細画面から行います。
* 各リソースの管理を行う画面にアクセスするにはログインが必要です。
* ログインは、プログラムを簡単にするために、ユーザIDのみで行います。

### 画面イメージ

**ログイン画面**

<img width="412" alt="login.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/27959/839fd35b-2a80-6b24-6885-a5b9c70a6970.png">

**予約新規登録画面**

<img width="384" alt="reservations_03.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/27959/bd5d01ed-db4a-2ede-5b29-5fc5b91fb81e.png">


### プロジェクトの説明

サンプルプログラムのソースコードには、Railsのプロジェクトが2つ含まれています。プロジェクトは`apps`ディレクトリに配置されています。

|プロジェクト名|用途|
|---|---|
|example|課題を終えた後の状態のソースコードです。Webサーバを起動し、Webブラウザからアクセスして操作できるようになっています。|
|web|課題を始める前の状態のソースコードです。|

### DB

DBは以下のテーブルで構成されています。

* ユーザ(users)
* 会議室(meeting_rooms)
* 予約(reservations)
* 予約ユーザ(reservation_users)

予約ユーザテーブルは、どの会議にどのユーザが参加するかを管理するための、中間テーブルです。

![Database.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/27959/72814760-8338-47ef-4c6d-8f8f90e1907c.png)

## 開発環境の構築

### Gitリポジトリのクローン

```sh
git clone git@github.com:ktakase00/mr2_demo.git
```

### webコンテナ用イメージ作成

```sh
docker pull ktakase00/rubypg-learn-mr2:uv-201908
```

## 開発環境の起動

* 「開発環境の構築」の手順が完了しているとする。

### ルートパス設定

ホストコンピュータ側で設定する。

* Gitリポジトリのルートディレクトリで( `docker-compose.yml` があるパスを指すように)設定する。

```sh
cd (Gitリポジトリのルートパス)
export LEARNING_ROOT="$(pwd)/2019/08/28_takase"
```

### dbコンテナ起動

```sh
cd $LEARNING_ROOT
docker-compose up -d db
```

### webコンテナ起動

```sh
cd $LEARNING_ROOT
bin/docker_run_web.sh
```

→webコンテナ内でbashが実行された状態になる。

### [example]webコンテナ内プロジェクトルートパス設定

補足

* exampleプロジェクトは開発済みの状態になっている。動作確認に使用する。
* webプロジェクトは開発中の状態になっている。実習に使用する。

webコンテナ内で設定する。

```sh
export EXAMPLE_ROOT=~/repo/apps/example
```

### [example]初期設定

webコンテナ内で実行する。

```sh
cd $EXAMPLE_ROOT
./setup.sh
```

### [example]rails起動

webコンテナ内で実行する。

```sh
cd $EXAMPLE_ROOT
bundle exec rails server -b 0.0.0.0
```

### [example]webアクセス

ホストコンピュータのWebブラウザでアクセスする。

```
http://localhost:4000/reservations
```

### [web]コンテナへの接続

webコンテナが起動されている状態とする。
ホストコンピュータ側で、新しいターミナルを開いて実行する。

```sh
cd (Gitリポジトリのルートパス)
export LEARNING_ROOT="$(pwd)/2019/08/28_takase"
cd $LEARNING_ROOT
bin/docker_exec_web.sh
```

### [web]webコンテナ内プロジェクトルートパス設定

webコンテナ内で設定する。

```sh
export WEB_ROOT=~/repo/apps/web
```

### [web]初期設定

webコンテナ内で実行する。

```sh
cd $WEB_ROOT
./setup.sh
```

### [web]RSpec実行

webコンテナ内で実行する。

```sh
cd $WEB_ROOT
bundle exec rspec -fd spec/requests
```

## 開発環境の停止

### rails停止

1. [web]のwebコンテナのbashを終了する。
2. [example]のwebコンテナ内でrailsを停止する。
3. [example]のwebコンテナのbashを終了する。

→webコンテナが破棄される。

### dbコンテナ停止

```sh
cd $LEARNING_ROOT
docker-compose down
```

→dbコンテナが破棄される。
