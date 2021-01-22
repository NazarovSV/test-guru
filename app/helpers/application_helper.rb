module ApplicationHelper
  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    link_to('Github', "https:/github.com/#{author}/#{repo}", target: '_blank', rel: 'nofollow')
  end

  def flash_message(type)
    return unless flash[type]

    content_tag :div, class: "alert #{message_type(type)} alert-dismissible fade show", role: 'alert' do
      content_tag(:span, flash[type]) +
        button_tag('', type: 'button', class: 'btn-close', data: { bs_dismiss: 'alert' }, aria: { label: 'Close' })
    end
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
