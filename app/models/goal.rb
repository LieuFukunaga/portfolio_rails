class Goal < ApplicationRecord
  belongs_to :list

  has_many :goal_categories, dependent: :destroy
  has_many :categories, through: :goal_categories

  accepts_nested_attributes_for :categories, allow_destroy: true
  accepts_nested_attributes_for :goal_categories, allow_destroy: true

  def save_category(inputs, checked_ids)

    all_categories = self.categories.pluck(:category_name) unless self.categories.nil? # 入力された新規カテゴリのcategory_nameを取得

    # チェックボックスのカテゴリが選択された場合
    if checked_ids != nil
      checked_category = []
      checked_ids.each do |checked_id|
        checked_category << Category.find(checked_id)
      end
      checked_category = checked_category.pluck(:category_name) unless checked_ids.nil?
      old_category = all_categories - inputs - checked_category # 既存・新規カテゴリ以外のカテゴリ
      new_category = inputs - all_categories #これから紐付けられるカテゴリ

    # チェックボックスのカテゴリが選択されなかった場合
    else
      old_category = all_categories - inputs
      new_category = inputs - all_categories
    end

    # 関連データもろともDestroy
    old_category.each do |old_name|
      Category.find_by(category_name:old_name).destroy
    end

    # Create
    new_category.each do |new_name|
      new_tag = Category.find_or_create_by(category_name: new_name) # 検索条件を指定、該当レコードが無ければ新規レコードを作成
      self.categories << new_tag
    end
  end

end
