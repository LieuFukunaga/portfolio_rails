# トップページのタスク検索で表示されるタスク（status更新後）のため

json.id @goal.id
json.list_name @goal.list.list_name
json.title @goal.title
json.status @goal.status
json.date @goal.date
json.list_id @goal.list_id
json.user_id @goal.user_id
json.user_sign_in current_user
json.created_at @goal.created_at
json.updated_at @goal.updated_at
# 画像のURLを習得
json.image url_for(@goal.image) if @goal.image.attached?