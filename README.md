# README

## アプリ名
Task 1-3-9

## アプリケーション概要
- 本アプリケーションは「マインドマップ」の特徴を取り入れたタスク管理アプリです。

- タスクごとに１つの「ゴール」とゴールを達成するための３つの「ステップ」、９つの「アクション」（各ステップに３つずつ）を設定することでユーザーの課題解決をサポートします。

- 各項目は「画像」と「単語（１０文字以下）」で構成されます。入力できる文字数を制限することで、各項目の要諦を考える必要性を生み出します。

- "1-3-9"（=>１つのゴールに３つのステップ、９つのアクション）というレイアウトは変更できません。ステップとアクションの数を制限することで、タスクの取捨選択と課題の切り分けを促します。

- 各タスクはそれぞれ１つの「リスト」に属します。また、リストとは別に複数の「カテゴリ」を設定し、整理することができます。

## 本番環境
- GitHub URL: https://github.com/LieuFukunaga/portfolio_rails
- URL: http://18.181.47.18

## データベース設計

ER図


### Usersテーブル
※ gem 'devise'が標準で持っているカラムは除く
|Column  |Type   |Options     |
|--------|-------|------------|
|name    |string |null: false |
|tel_num |string |null: false |

#### Association
- has_many :lists, dependent: :destroy
- has_many :addresses, dependent: :destroy
- has_namy :categories


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
|Column       |Type       |Options                                |
|-------------|-----------|---------------------------------------|
|list_name    |string     |null: false, index: true, unique: true |
|user_id      |references |foreign_key: true, index: true         |

#### Association
- belongs_to :user
- has_many :goals, dependent: :destroy


### Categoriesテーブル
|Column          |type   |Options                  |
|----------------|-------|-------------------------|
|category_name   |string |null: false, index: true |

#### Association
- has_many :goals, through: :goal_categories
- has_many :goal_categories, dependent: :destroy


### goal_Categoriesテーブル
|Column      |type       |Options                        |
|------------|-----------|-------------------------------|
|list_id     |references |foreign_key: true, index: true |
|category_id |references |foreign_key: true, index: true |

#### Association
- belongs_to :list
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


### Stepsテーブル
|Column  |Type       |Options              |
|--------|-----------|---------------------|
|title   |string     |null: false          |
|status  |integer    |limit: 1, default: 0 |
|goal_id |references |foreign_key: true    |

#### Association
- belongs_to :goal
- has_many :actions, dependent: :destroy


### Actionsテーブル
|Column  |Type       |Options              |
|--------|-----------|---------------------|
|title   |string     |null: false          |
|status  |integer    |limit: 1, default: 0 |
|step_id |references |foreign_key: true    |

#### Association
- belongs_to :step

### Active_Storage_Attachmentsテーブル

### Active_Storage_blobsテーブル