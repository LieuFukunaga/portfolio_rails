class List < ApplicationRecord
  belongs_to :user
  has_many :goals, dependent: :destroy

  validates :user_id, null: false
  validates :list_name, null: false, presence: true

  # def self.list_search(search)
  #   if search
  #     List.where("list_name LIKE(?)", "%#{search}%")
  #   end
  # end

  def self.split_keyword(search)
    split_keyword = search.split(/[[:blank:]]+/)                # 空文字で区切られている複数の検索ワードを分割できている
    split_first = split_keyword.group_by{|e| e}.select{|key, value| value.size > 1}.map(&:first)
    duplication_word = split_keyword.delete_if {|word| word != split_first[0]}
    split_keyword = search.split(/[[:blank:]]+/) - duplication_word + split_first
    return split_keyword
  end

  def self.list_search(search, user_id)
    if search.present?
      split_keyword = search.split(/[[:blank:]]+/)                # 空文字で区切られている複数の検索ワードを分割できている
      split_first = split_keyword.group_by{|e| e}.select{|key, value| value.size > 1}.map(&:first)
      duplication_word = split_keyword.delete_if {|word| word != split_first[0]}
      split_keyword = search.split(/[[:blank:]]+/) - duplication_word + split_first
      keyword_amount = split_keyword.length

      lists = []
      split_keyword.each do |keyword|
        next if keyword == ""                                     # 空文字の場合、処理をスキップ
        lists += List.where('list_name LIKE(?)', "%#{keyword}%")  # この段階では重複が発生している
      end

      # full_matched = lists.group_by{ |e| e }.select{ |key, value| value.size >= keyword_amount }
      # first = lists.group_by{ |e| e }.select{ |key, value| value.size > 1 }.map(&:first)
      lists = lists.group_by{ |e| e }.select{ |key, value| value.size >= keyword_amount }.map(&:first)
      # duplications = List.where(id: first.pluck(:id))
      # lists = lists - duplications + first

      lists.delete_if {|list| list.user_id != user_id}
    end
  end

  def self.task_search(search, user_id)
    if search.present?                            # 入力欄が空の場合にgoals.allを返させないためのpresent?
      # goals.where("title LIKE(?)", "%#{search}%") # whereが２重で掛けられている状態。user_idがcurrent_userのレコードの中から部分一致検索している
      split_keyword = search.split(/[[:blank:]]+/)

      tasks = []
      split_keyword.each do |keyword|
        next if keyword == ""
        tasks += Goal.where('title LIKE(?)', "%#{keyword}%")
      end

      first = tasks.group_by{ |e| e }.select{ |key, value| value.size > 1 }.map(&:first)
      duplications = Goal.where(id: first.pluck(:id))
      tasks = tasks - duplications + first

      tasks.delete_if {|task| task.user_id != user_id}
    end
  end

end
