require 'rails_helper'

describe 'Ideaモデル', type: :model do
  describe 'バリデーションのテスト' do
    let(:idea) { build(:idea) }
    subject { idea.valid? }

    context 'bodyカラム' do
      it '空欄でバリデートされる' do
        idea.body = ''
        is_expected.to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Categoryモデルとの関係' do
      it 'N:1となっている' do
        expect(Idea.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end
  end
end
