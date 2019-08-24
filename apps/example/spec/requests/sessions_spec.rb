require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /sessions/new" do
    it 'ログイン画面の表示に成功すること' do
      get new_session_path, headers: headers
      expect(response).to have_http_status(200)
#      puts response.body
    end
  end

  describe "POST /sessions" do
    # ログインのリクエストに与えるパラメータ
    let (:req_params) { { session_form: { user_cd: user.user_cd } } }

    describe '存在するユーザで' do
      # ユーザテーブルにレコードを登録しておく
      let (:user) { create(:user) }

      it 'ログインに成功すること' do
        post sessions_path, params: req_params, headers: headers
        expect(response).to redirect_to reservations_path
      end
    end

    describe '存在しないユーザで' do
      # ユーザテーブルにレコードは登録しない
      let (:user) { build(:user) }

      it 'ログインに失敗すること' do
        post sessions_path, params: req_params, headers: headers
        expect(response.body).to include '認証に失敗しました。'
      end
    end
  end
end
