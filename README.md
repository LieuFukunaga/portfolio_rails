# README

## アプリ名
Task 1-3-9

## アプリケーション概要
- 本アプリケーションは「マインドマップ」の特徴を取り入れたタスク管理アプリです。

- 各タスクに１個の「ゴール」とゴールを達成するための３個の「ステップ」、各ステップ３個ずつ（計９個）の「アクション」を設定できるフォーマットを提供します。

- "1-3-9"（=>１つのゴールに３つのステップ、９つのアクション）というレイアウトは変更できません。

- ユーザーは自身に紐づくリストを作成でき、各タスクはそれぞれ１つの「リスト」に属します。また、リストとは別に各タスクに自作の「カテゴリ」を複数設定できます。


## 本番環境
- GitHub URL: https://github.com/LieuFukunaga/portfolio_rails
- URL: http://18.181.47.184
※テストアカウントはございません。ご試用の際は、アカウントを作成してください。


##　工夫したポイント
本アプリの最大の特徴は3つのクラスのインスタンスを同一画面上で（複数個）作成し、計14件のテキストと画像を同時に保存できるところです。
goals#newで作成されたstepsテーブルのレコード（計3件）およびpracticesテーブルのレコード（計9件）はそれぞれが紐づくgoalsテーブルのid（practicesテーブルのレコードの場合はstepsテーブルのレコードidも）を外部キーとして持つことで、見た目だけではなくデータ上でも階層構造を表現しています。

また、タスクの件数が増えた場合の使い勝手を向上するためにlistsテーブル、goalsテーブルに対する「検索機能（AND検索、マイナス検索）」、検索結果に対する「ソート機能」、リストに対する「お気に入り登録機能」を実装しています。
加えて、"date"が現在時刻以後1週間以内に設定されているタスクがある場合、トップページ（lists#index）に表示されます。


## 使用言語
- Ruby(フレームワーク：Ruby on rails)
- JavaScript(jQuery)
- Haml
- SCSS


## 使用サービス
- AWS(EC2, S3)
- GitHub


## 使用アプリケーション
- Visual Studio Code
- Sequel Pro


## データベース設計

### Usersテーブル
※ gem 'devise'が標準で持っているカラムは除く
|Column  |Type   |Options     |
|--------|-------|------------|
|name    |string |null: false |
|tel_num |string |null: false |

#### Association
- has_many :lists, dependent: :destroy
- has_many :goals, dependent: :destroy
- has_many :steps, dependent: :destroy
- has_many :practices, dependent: :destroy
- has_many :addresses, dependent: :destroy
- has_namy :categories, dependent: :destroy


### Addressesテーブル
|Column     |Type       |Options              |
|-----------|-----------|---------------------|
|user_id    |references |foreign_key: true    |
|postcode   |string     |null: false          |
|prefecture |integer    |limit: 1, default: 0 |
|city       |string     |null: false          |
|building   |string     |

#### Association
- belongs_to :user, optional: true


### Listsテーブル
|Column       |Type       |Options                        |
|-------------|-----------|-------------------------------|
|list_name    |string     |null: false, index: true       |
|favorite     |integer    |limit: 1, default: 0           |
|user_id      |references |foreign_key: true, index: true |

#### Association
- belongs_to :user
- has_many :goals, dependent: :destroy
- has_many :steps, dependent: :destroy
- has_many :practices, dependent: :destroy


### Categoriesテーブル
|Column          |type       |Options                  |
|----------------|-----------|-------------------------|
|category_name   |string     |null: false, index: true |
|user_id         |references |foreign_key: true        |

#### Association
- has_many :goals, through: :goal_categories
- has_many :goal_categories, dependent: :destroy


### goal_Categoriesテーブル
|Column      |type       |Options                        |
|------------|-----------|-------------------------------|
|goal_id     |references |foreign_key: true, index: true |
|category_id |references |foreign_key: true, index: true |

#### Association
- belongs_to :goal
- belongs_to :category


### Goalsテーブル
|Column  |Type       |Options                 |
|--------|-----------|------------------------|
|title   |string     |null: false, index: true|
|status  |integer    |limit: 1, default: 0    |
|user_id |references |foreign_key: true       |
|list_id |references |foreign_key: true       |
|date    |datetime   |

#### Association
- belongs_to :user
- belongs_to :list
- has_many :categories, through: :goal_categories
- has_many :goal_categories, dependent: :destroy
- has_many :steps, dependent: :destroy
- has_many :practices, dependent: :destroy


### Stepsテーブル
|Column  |Type       |Options              |
|--------|-----------|---------------------|
|title   |string     |null: false          |
|status  |integer    |limit: 1, default: 0 |
|user_id |references |foreign_key: true    |
|list_id |references |foreign_key: true    |
|goal_id |references |foreign_key: true    |

#### Association
- belongs_to :user
- belongs_to :list
- belongs_to :goal
- has_many :practices

### Practicesテーブル
|Column  |Type       |Options              |
|--------|-----------|---------------------|
|title   |string     |null: false          |
|status  |integer    |limit: 1, default: 0 |
|user_id |references |foreign_key: true    |
|list_id |references |foreign_key: true    |
|goal_id |references |foreign_key: true    |
|step_id |references |foreign_key: true    |

#### Association
- belongs_to :user
- belongs_to :list
- belongs_to :goal
- belongs_to :step

### Active_Storage_Attachmentsテーブル
#### Userモデル
- has_one_attached: avatar
#### Goalモデル
- has_one_attached: image
#### Stepモデル
- has_one_attached: step_image
#### Practiceモデル
- has_one_attached: practice_image

### Active_Storage_blobsテーブル


## 今後の課題
#### goals#newでタスク新規作成時、入力内容がバリデーションに引っかかった際の画面表示の改善
- 開発当初、フォームの内容を保持したままタスク作成ページを再表示する予定でしたが、フォームが重複して描写されてしまう現象を解決できませんでした（fields_forが原因ではないかと推定）。よって、現段階ではリスト詳細ページをrenderするという回避策をとっています。
- 複数ユーザーでの利用に対応させたいです。ユーザーAに"招待"されることでユーザーBもユーザーAが作成したリストやタスク、カテゴリを利用・編集できるようになる、という仕様を目指します。



最後までお読みいただきありがとうございます。
以上