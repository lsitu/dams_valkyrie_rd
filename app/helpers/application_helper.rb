module ApplicationHelper
  def form_title(params)
    "#{params['action'].capitalize} #{params['controller'].humanize.singularize.downcase}"
  end
end
