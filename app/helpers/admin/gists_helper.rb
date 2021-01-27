module Admin::GistsHelper
  def url_gist_hash(url)
    url.split('/').last
  end
end
