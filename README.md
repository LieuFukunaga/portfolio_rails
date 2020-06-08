# README

## アプリ名
Task 1-3-9

## アプリケーション概要
- 本アプリケーションは「マインドマップ」の特徴を取り入れたタスク管理アプリです。

- 各タスクに１個の「ゴール」とゴールを達成するための３個の「ステップ」、各ステップ３個ずつ（計９個）の「アクション」を設定できるフォーマットを提供します。

- 各項目は「画像」と「単語（45文字以下）」で構成されます。

- "1-3-9"（=>１つのゴールに３つのステップ、９つのアクション）というレイアウトは変更できません。

- ユーザーは自身に紐づくリストを作成でき、各タスクはそれぞれ１つの「リスト」に属します。また、リストとは別に自作の「カテゴリ」を複数設定できます。


## 本番環境
- GitHub URL: https://github.com/LieuFukunaga/portfolio_rails
- URL: http://18.181.47.18


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