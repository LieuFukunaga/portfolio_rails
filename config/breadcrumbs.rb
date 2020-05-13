crumb :root do
  link "リスト一覧", root_path
end

crumb :lists_new do
  link "リスト作成ページ", new_list_path
end

crumb :lists_edit do
  link "リスト編集ページ", edit_list_path(List.find(params[:id]))
end

crumb :lists_show do
  link "タスク一覧ページ", list_path(List.find(params[:id]))
end

crumb :lists_search do
  link "リスト検索ページ", list_search_lists_path
end

crumb :lists_show do
  link "タスク一覧ページ", list_path(List.find(params[:id]))
end

crumb :goals_new do
  link "タスク作成ページ", new_list_goal_path(List.find(params[:list_id]))
end

crumb :goals_show do
  link "タスク編集ページ", list_goal_path(List.find(params[:list_id]), Goal.find(params[:id]))
end

crumb :goals_edit do
  link "タスク編集ページ", edit_list_goal_path(List.find(params[:list_id]), Goal.find(params[:id]))
end

crumb :tasks_search do
  link "タスク検索ページ", task_search_lists_path
end

crumb :categories_index do
  link "カテゴリ一覧ページ", categories_path
end

crumb :categories_show do
  link "カテゴリ一覧ページ", category_path(Category.find(params[:id]))
end

crumb :categories_edit do
  link "カテゴリ一覧ページ", edit_category_path(Category.find(params[:id]))
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