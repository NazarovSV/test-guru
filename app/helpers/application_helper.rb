module ApplicationHelper
  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    link_to('Github', "https:/github.com/#{author}/#{repo}", target: '_blank', rel: 'nofollow')
  end

  def flash_message(type)
    content_tag :p, flash[type], class: "flash #{type}" if flash[type]
  end

  def current_progress(total_question, current_question)
    ((current_question * 1.0) / total_question) * 100
  end

  def message_type(type)
    case type
    when 'notice' then 'alert-success'
    when 'alert' then 'alert-danger'
    else
      'alert-info'
    end
  end

  def answer_background_card(correct)
    correct ? 'bg-success' : 'bg-danger'
  end
end
