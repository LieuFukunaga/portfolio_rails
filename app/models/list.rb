class List < ApplicationRecord
  belongs_to :user
  has_many :goals, dependent: :destroy

  validates :user_id, null: false
  validates :list_name, null: false, presence: true


  # 検索ワード表示のため
  def self.split_keyword(search)
    split_keyword = search.split(/[[:blank:]]+/)

    unduplicated_first = split_keyword.group_by{ |e| e }.select{ |key, value| value.size > 1 }.map{ |key, value| value.first }
    unduplicated_words = split_keyword - unduplicated_first

    split_keyword = unduplicated_words + unduplicated_first
  end


  # リスト検索のため
  def self.list_search(search, user_id)
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

      lists = []
      split_keyword.each do |keyword|
        next if keyword == "" # 空文字だけの場合、処理をスキップ
        lists += List.where('list_name LIKE(?)', "%#{keyword}%") # この段階では重複が発生している
      end

      lists = lists.group_by{ |e| e }.select{ |key, value| value.size >= 1 }.map(&:first) # 部分一致している検索結果を配列化
      lists.delete_if{ |list| list.user_id != user_id } # 検索結果から、ログインユーザに紐づくリストを抽出

      if minus_keyword.length != 0
        minus_lists = []
        minus_keyword.each do |keyword|
          next if keyword == ""
          minus_lists += List.where('list_name LIKE(?)', "%#{keyword}%")
        end

        minus_lists.each do |minus_list|
          lists.delete(minus_list)
        end
      end

      return lists
    end
  end


  # タスク検索のため
  def self.task_search(search, user_id)
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
      tasks.sort!{|a,b| a.title <=> b.title}

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

  #     # リスト内タスク検索のため
  # def self.search_in_list(search, user_id, list_id)
  #   if search.present?
  #     split_keyword = search.split(/[[:blank:]]+/) # 空文字で区切られている複数の検索ワードを分割

  #     # ひらがなをカタカナに、カタカナをひらがなに変換
  #     tr_keyword = split_keyword.map{|word| word.tr('ァ-ンぁ-ん','ぁ-んァ-ン')}
  #     # ひらがな・カタカナ、両方で検索
  #     split_keyword += tr_keyword

  #     # 全角を半角に、半角を全角に変換
  #     zenkaku = split_keyword.map{|word| word.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ')}
  #     hankaku = split_keyword.map{|word| word.tr('０-９ａ-ｚＡ-Ｚ','0-9a-zA-Z')}
  #     # 全角・半角、両方で検索
  #     split_keyword += zenkaku
  #     split_keyword += hankaku

  #     # 複数ワードの重複を削除
  #     unduplicated_first = split_keyword.group_by{ |e| e }.select{ |key, value| value.size > 1 }.map{ |key, value| value.first } # 重複している単語を取得、配列化
  #     unduplicated_words = split_keyword - unduplicated_first
  #     split_keyword = unduplicated_words + unduplicated_first

  #     # マイナス検索用
  #     minus_keyword = split_keyword.select { |word| word.match(/\A-.+/) }
  #     if minus_keyword.length != 0
  #       split_keyword.reject!{ |word| word.match(/\A-.+/) }
  #       minus_keyword.each{ |word| word.slice!(/\A-/) }
  #     end

  #     tasks = []
  #     split_keyword.each do |keyword|
  #       next if keyword == "" # 空文字だけの場合、処理をスキップ
  #       tasks += Goal.where('title LIKE(?)', "%#{keyword}%") # この段階では重複が発生している
  #     end

  #     tasks = tasks.group_by{ |e| e }.select{ |key, value| value.size >= 1 }.map(&:first)   # キーワードすべてに部分一致している検索結果を配列化
  #     tasks.delete_if { |task| task.user_id != user_id } # 検索結果から、ログインユーザに紐づくリストを抽出
  #     tasks.delete_if { |task| task.list_id != list_id} # 検索を実行したリスト内のタスクのみを抽出
  #     tasks.sort!{|a,b| a.title <=> b.title}

  #     if minus_keyword.length != 0
  #       minus_tasks = []
  #       minus_keyword.each do |keyword|
  #         next if keyword == ""
  #         minus_tasks += Goal.where('title LIKE(?)', "%#{keyword}%")
  #       end

  #       minus_tasks.each do |minus_list|
  #         tasks.delete(minus_list)
  #       end
  #     end

  #     return tasks
  #   end
  # end

end
