class Goal < ApplicationRecord
  belongs_to :list
  belongs_to :user

  has_many :goal_categories, dependent: :destroy
  has_many :categories, through: :goal_categories

  validates :title, length: { minimum: 0, maximum: 20 }
  validates :title, null: false, presence: true

  accepts_nested_attributes_for :categories, allow_destroy: true
  accepts_nested_attributes_for :goal_categories, allow_destroy: true

  has_one_attached :image

  enum status: {
    doing: 0,
    done: 1,
  }

  def save_category(inputs, checked_ids)

    # 入力された新規カテゴリのcategory_nameを取得
    all_categories = self.categories unless self.categories.nil?
    all_categories_name = all_categories.pluck(:category_name)
    all_categories_id = all_categories.pluck(:user_id)[0]


    # チェックボックスのカテゴリが選択された場合
    if checked_ids != nil
      checked_category = []
      checked_ids.each do |checked_id|
        checked_category << Category.find(checked_id)
      end
      checked_category = checked_category.pluck(:category_name) unless checked_ids.nil?
      old_category = all_categories_name - inputs - checked_category # 既存・新規カテゴリ以外のカテゴリ
      new_category = inputs - all_categories_name #これから紐付けられるカテゴリ
    # チェックボックスのカテゴリが選択されなかった場合
    else
      old_category = all_categories_name - inputs
      new_category = inputs - all_categories
    end

    # 関連データもろともDestroy
    old_category.each do |old_name|
      Category.find_by(category_name:old_name).destroy
    end

    # Create
    new_category.each do |new_name|
      self.categories << Category.find_or_create_by(category_name: new_name, user_id: all_categories_id) # 検索条件を指定、該当レコードが無ければ新規レコードを作成
    end

  end


  def update_category(added_categories, update_ids)
    # 更新するレコードに紐づくすべてのカテゴリを取得
    all_categories = self.categories unless self.categories.nil?
    all_categories_name = all_categories.pluck(:category_name)
    all_categories_id = all_categories.pluck(:user_id)[0]
    # チェックボックスのカテゴリが選択されている場合
    if update_ids != nil
      # 選択されたカテゴリのidを元にレコードを取得、配列に格納
      already_registered = []
      update_ids.each do |update_id|
        already_registered << Category.find(update_id)
      end
      already_registered = already_registered.pluck(:category_name) unless update_ids.nil?
      old_category = all_categories_name - added_categories - already_registered # 既存・新規カテゴリ以外のカテゴリ
      new_category = added_categories - all_categories_name #これから紐付けられるカテゴリ

      # チェックボックスのカテゴリが選択されなかった場合
    else
      old_category = all_categories - updates
      new_category = updates - all_categories
    end

    # 関連データもろともDestroy
    old_category.each do |old_name|
      Category.find_by(category_name: old_name).destroy
    end

    # Create
    new_category.each do |new_name|
      self.categories << Category.find_or_create_by(category_name: new_name, user_id: all_categories_id) # 検索条件を指定、該当レコードが無ければ新規レコードを作成
    end
  end

end
