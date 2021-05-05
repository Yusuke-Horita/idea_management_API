require 'rails_helper'

describe 'Categoryモデル', type: :model do
	describe "バリデーションのテスト" do
		let(:category) { build(:category) }
		let(:category_2) { create(:category) }
		subject { category.valid? }

		context "nameカラム" do
			it "空欄でバリデートされる" do
				category.name = ""
				is_expected.to eq false
			end
			it "重複でバリデートされる" do
				category.name = category_2.name
				is_expected.to eq false
			end
		end
	end
	describe "アソシエーションのテスト" do
		context "Ideaモデルとの関係" do
			it "1:Nとなっている" do
				expect(Category.reflect_on_association(:ideas).macro).to eq :has_many
			end
		end
	end
end