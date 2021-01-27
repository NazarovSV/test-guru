class GistQuestionService
  Result = Struct.new(:responce, :url, :success?)

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || default_client
  end

  def call
    responce = @client.create_gist(gist_params)
    Result.new(responce, html_url(responce), success?(responce))
  end

  private

  def default_client
    Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])
  end

  def gist_params
    {
      description: I18n.t('services.gist_question_service.description', title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }
  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:variant)
    content.join("\n")
  end

  def html_url(responce)
    responce&.html_url
  end

  def success?(responce)
    responce&.html_url.present?
  end
end
