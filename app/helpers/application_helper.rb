module ApplicationHelper

  def nav_link(text, path)
    link_to(text, path, class: "nav-link #{request.path == path ? "active" : nil}")
  end
end
