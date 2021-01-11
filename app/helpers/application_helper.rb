module ApplicationHelper
  def current_year
    "Current year: #{Time.current.year}"
  end

  def github_url(author, repo)
    link_to('Github', "https:/github.com/#{author}/#{repo}", target: '_blank', rel: 'nofollow')
  end

  def flash_message(key)
    content_tag :p, flash[key], class: "flash #{key}" if flash[key]
  end
end
