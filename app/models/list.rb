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

  def self.list_search(search, user_id)
    if search.present?
      split_keyword = search.split(/[[:blank:]]+/)                # 空文字で区切られている複数の検索ワードを分割できている

      lists = []
      split_keyword.each do |keyword|
        next if keyword == ""                                     # 空文字の場合、処理をスキップ
        lists += List.where('list_name LIKE(?)', "%#{keyword}%")  # この段階では重複が発生している
      end

      first = lists.group_by{ |e| e }.select{ |key, value| value.size > 1 }.map(&:first)
      duplications = List.where(id: first.pluck(:id))
      lists = lists - duplications + first

      lists.delete_if {|list| list.user_id != user_id}
      # binding.pry
    end
  end

  def self.task_search(goals, search)
    if search.present?                            # 入力欄が空の場合にgoals.allを返させないためのpresent?
      goals.where("title LIKE(?)", "%#{search}%") # whereが２重で掛けられている状態。user_idがcurrent_userのレコードの中から部分一致検索している
    end
  end

end
