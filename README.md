# Eureka
 研究論文や書籍などで知った科学的な知見を記事として共有するSNS風アプリです。
 
 自分は大学院で数年研究をしておりましたが、一般の方々にとって学術研究は敷居の高いものであったり、縁のないものという印象を持たれていると感じました。
 
 そこで研究の面白さ、身近さが共有できるようなwebサービスがあって欲しいという思いから作成しました。
 <img width="1255" alt="screenshot" src="https://user-images.githubusercontent.com/59919826/85216075-761ba180-b3bb-11ea-81dc-740969873745.png">
 
# 制作環境
Ruby 2.5.1

Rails 5.2

Nginx + puma

AWS(ECS+ECR, RDS(mysql), Route53, SES, ACM, S3, Cloudfront), Docker

CircleCIによるCI/CDパイプラインの構築

![architecture](https://user-images.githubusercontent.com/59919826/85216025-d52ce680-b3ba-11ea-8c6a-2c6923cccc8b.png)

# URL

https://host.eureeeeka.com

# 機能一覧

・ユーザー登録機能

・ユーザーのフォロー機能/ Ajax

・アカウント登録時の有効化、パスワードリセット時にメールを送信/ AWS:SES

・ログイン機能

・記事投稿機能（エンリッチテキスト）/ gem: action-text

・タグ機能/ gem:acts_as_taggable_on

・検索機能（記事のタイトル・内容・タグ・カテゴリから検索）/ gem:ransack

・お気に入り機能/ Ajax
