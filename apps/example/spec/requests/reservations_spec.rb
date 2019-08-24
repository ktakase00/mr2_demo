require 'rails_helper'

module ReservationsSpecHelper
  # 日時を年、月、日、時、分に分解する
  def datetime_attrs(model, attr_key)
    attr_value = model.public_send(attr_key)
    {
      "#{attr_key}(1i)": attr_value.year,
      "#{attr_key}(2i)": attr_value.mon,
      "#{attr_key}(3i)": attr_value.mday,
      "#{attr_key}(4i)": attr_value.hour,
      "#{attr_key}(5i)": attr_value.min,
    }
  end

  # ユーザの配列から予約のnested attributes用のハッシュを生成する
  def nested_reservation_users(others)
    others.each_with_index.map { |user, idx| [ idx, { user_id: user.id } ] }.to_h
  end

  # 予約のリクエストに与えるパラメータを生成
  def reservation_req_params(reservation)
    others = reservation.reservation_users.map { |it| it.user }
    reservation.serializable_hash(only: [
      :title,
      :meeting_room_id,
      :memo_content,
    ]).merge(
      datetime_attrs(reservation, :start_at)
    ).merge(
      datetime_attrs(reservation, :end_at)
    ).merge({
      reservation_users_attributes: nested_reservation_users(others)
    })
  end
end

RSpec.describe "Reservations", type: :request do
  include ReservationsSpecHelper

  let (:login_user) { create(:user) }

  before (:each) do
    post sessions_path, params: { session_form: { user_cd: login_user.user_cd } }, headers: headers
  end

  describe "GET /reservations/new" do
    it "works! (now write some real specs)" do
      get new_reservation_path
      expect(response).to have_http_status(200)
#      puts response.body
    end
  end

  describe "POST /reservations" do
    # 事前条件(会議室1件、参加候補ユーザ2件)
    let (:meeting_room) { create(:meeting_room) }
    let (:others) { create_list(:user, 2) }

    # 新規登録する予約のパラメータ
    let (:reservation_attrs) {
      {
        user_id: login_user.id,
        meeting_room_id: meeting_room.id,
        start_at: Time.parse('2019-08-01 10:00:00+09'),
        end_at: Time.parse('2019-08-01 11:00:00+09'),
        reservation_users_attributes: nested_reservation_users(others),
      }
    }
    let (:reservation) { build(:reservation, reservation_attrs) }
    let (:req_params) { { reservation: reservation_req_params(reservation) } }

    describe '新規登録に' do
      let (:created_reservation) { Reservation.last }

      it '成功すること' do
        post reservations_path, params: req_params, headers: headers
        expect(response).to redirect_to reservation_path(created_reservation.id)
      end
    end

    describe 'すでに予約されている場合' do
      # あらかじめ同時刻の予約を登録しておく
      let! (:prepare_reserved) { create(:reservation, reservation_attrs) }

      it '予約済みで失敗すること' do
        post reservations_path, params: req_params, headers: headers
        expect(response.body).to include '会議室は予約されています'
      end
    end
  end
end
