# これは何？
* lets-chatとfaecbook messengerのチャットルームを相互に中継するhubotです。

# 設定方法
* 設定ファイルは ./bin/hubot と config.json,  config_relay.json です。
 * config.jsonにbotとして動かすfacebookアカウントのidとpasswordを記載します。
```config.json
{
  "email": "test@test.com",
  "password": "yourpassword"
}
```

 * config_relay.jsonで対応するfacebookとletschatそれぞれのroom idを指定します。

```config_relay.json
{
  "chatrooms": [
    { "title": "chat room #1",
      "letschat": "letschat room id",
      "facebook": "facebook chat id" },
    { "title": "chat room #2",
      "letschat": "letschat room id",
      "facebook": "facebook chat id" }
  ]
}
```

 * ./bin/hubotでletschatのサーバアドレス、ポート、room id、そしてbotとして動かすアカウントのaccess tokenを指定します。
```./bin/hubot
export HUBOT_LCB_PORT=5002
export HUBOT_LCB_HOSTNAME=127.0.0.1
export HUBOT_LCB_ROOMS=xxxxx,xxxxx,xxxxx (lets-chatのroomのリスト)
export HUBOT_LCB_TOKEN=xyz (lets-chatのbotを動かすユーザのアクセストークン)
```

# 起動方法
* 何かエラーが起こった場合には、プロセスを終了するようにしています。
* なので、以下のように、foreverを使ってプロセスの死活監視をするのがオススメです。

```
forever start -a -c /bin/bash ./bin/hubot
```
