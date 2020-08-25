class Goal < ApplicationRecord
  belongs_to :list
  belongs_to :user

  has_many :steps, dependent: :destroy
  has_many :practices, dependent: :destroy

  has_many :goal_categories, dependent: :destroy
  has_many :categories, through: :goal_categories

  accepts_nested_attributes_for :steps, allow_destroy: true
  accepts_nested_attributes_for :practices, allow_destroy: true
  accepts_nested_attributes_for :categories, allow_destroy: true
  accepts_nested_attributes_for :goal_categories, allow_destroy: true

  has_one_attached :image

  # validates :title, format: {with:/\A[^[:blank:]\s、,]+\z/}
  validates :title, length: { minimum: 0, maximum: 45 }
  validates :title, null: false, presence: true

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
      old_category = all_categories_name - added_categories
      new_category = added_categories - all_categories_name
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




  # 検索ワード表示のため
  def self.split_keyword(search)
    split_keyword = search.split(/[[:blank:]]+/)

    unduplicated_first = split_keyword.group_by{ |e| e }.select{ |key, value| value.size > 1 }.map{ |key, value| value.first }
    unduplicated_words = split_keyword - unduplicated_first

    split_keyword = unduplicated_words + unduplicated_first
  end

  # リスト内タスク検索のため
  def self.search_in_list(search, user_id, list_id)
    if search.present?
      split_keyword = search.split(/[[:blank:]]+/) # 空文字で区切られている複数の検索ワードを分割

      # ひらがなをカタカナに、カタカナをひらがなに変換
      tr_keyword = split_keyword.map{|word| word.tr('ァ-ンぁ-ん','ぁ-んァ-ン')}
      # ひらがな・カタカナ、両方で検索
      split_keyword += tr_keyword

      # 全角を半角に、半角を全角に変換
      zenkaku = split_keyword.map{|word| word.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')}
      hankaku = split_keyword.map{|word| word.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')}
      # 全角・半角、両方で検索
      split_keyword += zenkaku
      split_keyword += hankaku

      # 複数ワードの重複を削除
      unduplicated_first = split_keyword.group_by{ |e| e }.select{ |key, value| value.size > 1 }.map{ |key, value| value.first } # 重複している単語を取得、配列化
      unduplicated_words = split_keyword - unduplicated_first
      split_keyword = unduplicated_words + unduplicated_first

      # マイナス検索用
      minus_keyword = split_keyword.select { |word| word.match(/\A-.+/) }
      if minus_keyword.length != 0
        split_keyword.reject!{ |word| word.match(/\A-.+/) }
        minus_keyword.each{ |word| word.slice!(/\A-/) }
      end

      tasks = []
      split_keyword.each do |keyword|
        next if keyword == "" # 空文字だけの場合、処理をスキップ
        tasks += Goal.where('title LIKE(?)', "%#{keyword}%") # この段階では重複が発生している
      end

      tasks = tasks.group_by{ |e| e }.select{ |key, value| value.size >= 1 }.map(&:first)   # キーワードすべてに部分一致している検索結果を配列化
      tasks.delete_if { |task| task.user_id != user_id } # 検索結果から、ログインユーザに紐づくリストを抽出
      tasks.delete_if { |task| task.list_id != list_id} # 検索を実行したリスト内のタスクのみを抽出
      # tasks.sort!{|a,b| a.title <=> b.title}

      if minus_keyword.length != 0
        minus_tasks = []
        minus_keyword.each do |keyword|
          next if keyword == ""
          minus_tasks += Goal.where('title LIKE(?)', "%#{keyword}%")
        end

        minus_tasks.each do |minus_list|
          tasks.delete(minus_list)
        end
      end

      return tasks
    end
  end

end

