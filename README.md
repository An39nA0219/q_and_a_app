# README

Q&A アプリです
全体的に　 logged*in? is_for_admin*でカバーする
Routing の table がきれいに表示出来てない

# DB 設計

- users
  - name
  - email
  - password
  - admin
- questions
  - user_id
  - title
  - body
  - solved
- answers
  - question_id
  - user_id
  - body

# Routing

| やりたいこと                             | HTTP メソッド | エンドポイント        | コントローラ#アクション  |
| :--------------------------------------- | :------------ | :-------------------- | :----------------------- |
| ユーザー登録画面を表示する               | GET           | /signup               | users#new                |
| ユーザー登録をする                       | POST          | /users                | users#create             |
| ログイン画面を表示する                   | GET           | /login                | sessions#new             |
| ログインする                             | POST          | /login                | sessions#create          |
| 質問一覧を表示する（全て）               | GET           | /questions            | questions#index          |
| 質問一覧を表示する（未解決）             | GET           | /questions/unsolved   | questions#unsolved       |
| 質問一覧を表示する（解決済み）           | GET           | /questions/solved     | questions#solved         |
| 質問投稿ページを表示する                 | GET           | /questions/new        | questions#new            |
| 質問投稿をする                           | POST          | /questions            | questions#create         |
| 質問詳細を表示する                       | GET           | /questions/:id        | questions#show           |
| 質問編集ページを表示する                 | GET           | /questions/:id/edit   | questions#edit           |
| 質問を削除する                           | DELETE        | /questions/:id        | questions#destroy        |
| 回答する                                 | POST          | /answers              | answers#create           |
| ユーザー一覧を表示する                   | GET           | /users                | users#index              |
| 管理画面用のログインページを表示する     | GET           | /admins/login         | admins/sessions#new      |
| （管理画面）質問一覧ページを表示する     | GET           | /admins/questions     | admins/questions#index   |
| （管理画面）質問を削除する               | DELETE        | /admins/questions/:id | admins/questions#destroy |
| （管理画面）ユーザー一覧ページを表示する | GET           | /admins/users         | admins/users#index       |
| （管理画面）ユーザーを削除する           | DELETE        | /admins/users/:id     | admins/users#destroy     |
