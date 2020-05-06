class Goal < ApplicationRecord
  belongs_to :list
  has_many :goal_categories, dependent: :destroy
  has_many :categories, through: :goal_categories

  accepts_nested_attributes_for :categories, allow_destroy: true

  # 以下、カテゴリ機能のため
  def save_category(inputs)
    # すでにリストに紐付いているカテゴリの名称をすべて取得
    current_categories = self.categories.pluck(:category_name) unless self.categories.nil?
    old_category = current_categories - inputs #入力されたカテゴリ以外の既存のカテゴリ
    # binding.pry
    new_category = inputs - current_categories #新たに登録されるカテゴリ

    # いったん消して、改めて付ける方式

    # Delete
    old_category.each do |old_name|
      self.categories.delete(Category.find_by(category_name:old_name))
    end

    # Create
    new_category.each do |new_name|
      # 検索条件を指定、該当レコードが無ければ新規レコードを作成
      new_tag = Category.find_or_create_by(category_name: new_name)
      self.categories << new_tag
    end
  end

end
