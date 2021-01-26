class GistQuestionService
  Result = Struct.new(:responce) do
    def html_url
      responce&.html_url
    end

    def success?
      responce&.html_url.present?
    end
  end

  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || default_client
  end

  def call
    Result.new(@client.create_gist(gist_params))
  end

  def gist_created?
    @successfull
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
end
