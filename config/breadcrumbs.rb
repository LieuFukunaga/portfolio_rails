crumb :root do
  link "ホーム", root_path
end

crumb :users_show do
  link "マイページ", user_path(current_user)
end

crumb :users_edit do
  link "ユーザー情報編集", user_path(current_user)
end

crumb :lists_new do
  link "リスト作成", new_list_path
end

crumb :lists_edit do
  link "リスト編集", edit_list_path(List.find(params[:id]))
end

crumb :lists_show do
  link "”#{List.find(params[:id]).list_name}” のタスク一覧", list_path(List.find(params[:id]))
end

crumb :lists_search do
  link "リスト検索", list_search_lists_path
end

crumb :goals_task_search_in_list do
  link "リスト内検索", task_search_in_list_list_goals_path(List.find(params[:list_id]))
end

crumb :goals_new do
  link "タスク作成", new_list_goal_path(List.find(params[:list_id]))
end

crumb :goals_show do
  link "タスク詳細", list_goal_path(List.find(params[:list_id]), Goal.find(params[:id]))
end

crumb :goals_edit do
  link "タスク編集", edit_list_goal_path(List.find(params[:list_id]), Goal.find(params[:id]))
end

crumb :tasks_search do
  link "タスク検索", task_search_lists_path
end

crumb :categories_index do
  link "カテゴリ一覧", categories_path
end

crumb :categories_show do
  link "カテゴリ詳細ページ", category_path(Category.find(params[:id]))
end

crumb :categories_edit do
  link "カテゴリ編集ページ", edit_category_path(Category.find(params[:id]))
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).