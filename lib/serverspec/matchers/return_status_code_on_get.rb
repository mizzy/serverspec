RSpec::Matchers.define :return_status_code_on_get do |status|
  match do |uri|
    uri.http_get_matches_status_code?(status)
  end
end
