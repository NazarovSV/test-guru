class GistQuestionService
  def initialize(question, client: nil)
    @question = question
    @test = @question.test
    @client = client || default_client
  end

  def call
    result = @client.create_gist(gist_params)
    @successfull = result&.html_url.present?
    result
  end

  def gist_created?
    @successfull
  end

  private

  def default_client
    Octokit::Client.new(access_token: '34dae244d09b1bc9a2743844d165d284d185b934')
  end

  def gist_params
    {
      description: "A question about #{@test.title} from TestGuru",
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
