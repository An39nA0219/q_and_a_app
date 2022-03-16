# README

Q&Aアプリです

# DB設計
* users
  * name
  * email
  * password
  * is_admin
* questions
  * user_id
  * title
  * content
  * is_solved
* answers
  * question_id
  * answerer_id
  * content
