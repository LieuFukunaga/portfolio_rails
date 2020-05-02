# README

## アプリ名
Task 1-3-9

## アプリケーション概要
- 本アプリケーションは「マインドマップ」の特徴を取り入れたタスク管理アプリです。

- タスクごとに１つの「ゴール」とゴールを達成するための３つの「ステップ」、９つの「アクション」（各ステップに３つずつ）を設定することでユーザーの課題解決をサポートします。

- 各項目は「画像」と「単語（１０文字以下）」で構成されます。入力できる文字数を制限することで、各項目の要諦を考える必要性を生み出します。

- "1-3-9"（=>１つのゴールに３つのステップ、９つのアクション）というレイアウトは変更できません。ステップとアクションの数を制限することで、タスクの取捨選択と課題の切り分けを促します。

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

### Association
- has_many :lists, dependent: :destroy


### Addressesテーブル
|Column     |Type       |Options              |
|-----------|-----------|---------------------|
|user_id    |references |foreign_key: true    |
|postcode   |string     |null: false          |
|prefecture |integer    |limit: 1, default: 0 |
|city       |string     |null: false          |
|building   |string     |

### Association
- belongs_to :user, optional: true


### Listsテーブル
|Column  |Type       |Options           |
|--------|-----------|------------------|
|name    |string     |null: false       |
|user_id |references |foreign_key: true |
|tag     |

### Association
- belongs_to :user
- has_many :goals


### Goalsテーブル
|Column  |Type       |Options              |
|--------|-----------|---------------------|
|name    |string     |null: false          |
|status  |integer    |limit: 1, default: 0 |
|list_id |references |foreign_key: true    |

### Association
- belongs_to :list
- has_many :steps, dependent: :destroy


### Stepsテーブル
|Column  |Type       |Options              |
|--------|-----------|---------------------|
|name    |string     |null: false          |
|status  |integer    |limit: 1, default: 0 |
|goal_id |references |foreign_key: true    |

### Association
- belongs_to :goal
- has_many :actions, dependent: :destroy


### Actionsテーブル
|Column  |Type       |Options              |
|--------|-----------|---------------------|
|name    |string     |null: false          |
|status  |integer    |limit: 1, default: 0 |
|step_id |references |foreign_key: true    |

### Association
- belongs_to :step

### Active_Storage_Attachmentsテーブル

### Active_Storage_blobsテーブル