require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  include AuthHelper

  describe "POST users#create" do
    let(:attributes) {
      {
        "data"=>"{\"uuid\":\"f28df85a-6669-4988-8d58-d2472dbe7ea5\",\"full_name\":\"Sothida\",\"password\":\"123\",\"username\":\"Sothida\",\"sex\":\"ស្រី\",\"photo\":\"\",\"date_of_birth\":\"07-May-2019\",\"phone_number\":\"090999888\",\"grade\":\"other\",\"version\":\"ios 1.4.0\"}",
        "photo"=>Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/user_profile.png'), 'image/jpeg')
      }
    }

    let(:user_uuid) {'f28df85a-6669-4988-8d58-d2472dbe7ea5'}

    before(:each) do
      http_login
    end

    context 'success' do
      it { expect { post :create, { params: attributes } }.to change(User, :count).by(1) }
    end

    context 'photo' do
      before(:each) do
        post :create, { params: attributes  }
      end

      it { expect(User.find_by(uuid: user_uuid).photo).not_to be_nil }

      it "has no a photo" do
        post :create, { params: attributes.merge("photo": "")  }
        expect(User.find_by(uuid: user_uuid).photo.present?).to be_falsey
      end
    end
  end
end
