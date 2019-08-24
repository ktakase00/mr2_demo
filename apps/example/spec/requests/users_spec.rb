require 'rails_helper'

module UsersRequestSpecHelper
  # ユーザの配列から予約のnested attributes用のハッシュを生成する
  def nested_reservation_users(others)
    others.each_with_index.map { |user, idx| [ idx, { user_id: user.id } ] }.to_h
  end
end

RSpec.describe "Users", type: :request do
  include UsersRequestSpecHelper

  let (:login_user) { create(:user) }

  before (:each) do
    post sessions_path, params: { session_form: { user_cd: login_user.user_cd } }, headers: headers
  end

  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /users" do
    # 新規登録するユーザ
    let (:user) { build(:user) }
    # HTTPリクエストに与えるパラメータ
    let (:req_params) { { user: user.serializable_hash(only: [:user_cd, :user_nm]) } }

    # 事前条件(会議室1件、参加候補ユーザ2件、予約2件)
    let (:meeting_room) { create(:meeting_room) }
    let (:others) { create_list(:user, 2) }
    let (:reservation_attrs) do
      {
        user_id: login_user.id,
        meeting_room_id: meeting_room.id,
        reservation_users_attributes: nested_reservation_users(others),
      }
    end
    let (:reservation_base_at) { Time.parse('2019-08-01 10:00:00+09') }
    let! (:reservations) do
      # 1時間の予約を時間違いで2件登録する
      (0..1).map do |i|
        meeting_time_attrs = {
          start_at: reservation_base_at + i.hour,
          end_at: reservation_base_at + (i + 1).hour,
        }
        create(:reservation, reservation_attrs.merge(meeting_time_attrs))
      end
    end

    describe '予約が存在する状態でユーザの新規登録を行うと' do
      let (:created_user) { User.last }
      let (:created_reservation_users) { ReservationUser.where({ user_id: created_user.id }) }

      it '新しいユーザが予約ユーザに追加されること' do
        # 実行
        post users_path, params: req_params, headers: headers

        # ユーザ詳細画面にリダイレクトされること
        expect(response).to redirect_to user_path(created_user.id)
        # 予約ユーザテーブルのすべての予約について新しいユーザが追加されていること
        expect(created_reservation_users.length).to eq(reservations.length)
      end
    end
  end
end
