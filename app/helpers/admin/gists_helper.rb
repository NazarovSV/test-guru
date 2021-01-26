module Admin::GistsHelper
  def url_hash(url)
    url.split('/').last
  end
end
