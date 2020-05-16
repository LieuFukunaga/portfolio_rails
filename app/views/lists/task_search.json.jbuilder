json.array! @tasks do |task|
  json.id task.id
  json.list_name task.list.list_name
  json.title task.title
  json.status task.status_i18n
  json.date task.date
  json.list_id task.list_id
  json.user_id task.user_id
  json.user_sign_in current_user
  json.created_at task.created_at
  json.updated_at task.updated_at
  # 画像のURLを習得
  json.image url_for(task.image) if task.image.attached?
end