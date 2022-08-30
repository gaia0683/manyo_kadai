# README

| user |
||
||

| task    |
| :------ | :----- |
| name    | string |
| content | text   |

model Users
t.string name
t.string email
t.text password_digest

model Tasks
t.string name
t.text content
t.datetime end_time
t.integer rank
t.string status

model Labels
t.stirng class

Heroku へのデプロイ手順

1. ターミナルで heroku create を実行し、heroku 上にアプリを製作(最初にデプロイする際に実行して以降は実行する必要なし)
2. git commit を実行してコミットする
3. heroku buildpacks:set heroku/ruby,heroku buildpack:add --index1 heroku/nodejs を実行して
   作成したアプリを heroku 上でコンパイルできるようにする。
   (上記したコードの２行目は追加で node.js をコンパイルするために追加したコードです。)
