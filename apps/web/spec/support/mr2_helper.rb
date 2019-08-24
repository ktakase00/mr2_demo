RSpec.shared_context :mr2_shared_context do
  let (:headers) { { 'Accept-Language' => 'ja' } }
end

RSpec.shared_context :execute_with_login do
  let (:login_user) { create(:user) }

  before (:each) do
    post sessions_path, params: { session_form: { user_cd: login_user.user_cd } }, headers: headers
  end
end

RSpec.configure do |config|
  config.include_context :mr2_shared_context, type: :request
end
