require 'rails_helper'

describe 'IdeaAPI', type: :request do
  let(:idea) { create(:idea) }
  let(:ideas) { create_list(:idea, 10) }
  context 'アイデアの登録' do
    it '登録に成功し、ステータスコード201が返ってくる' do
      params = {
        category_name: Faker::Lorem.characters(number: 10),
        body: Faker::Lorem.sentence(word_count: 3)
      }
      expect { post ideas_path, params: params }.to change(Idea, :count).by(+1)
      expect(response.status).to eq(201)
    end
    it '空欄で登録に失敗し、ステータスコード422が返ってくる' do
      expect { post ideas_path }.to_not change(Idea, :count)
      expect(response.status).to eq(422)
    end
  end
  context 'アイデアの取得' do
    it 'category_nameを指定せず、全てのアイデアを取得' do
      idea
      ideas
      get ideas_path
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['data'].length).to eq(11)
      expect(json['data'][0]['id']).to eq idea.id
      expect(json['data'][0]['category']).to eq idea.category.name
      expect(json['data'][0]['body']).to eq idea.body
    end
    it 'category_nameを指定し、該当するアイデアを取得' do
      idea
      ideas
      get ideas_path, params: { category_name: idea.category.name }
      json = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(json['data'].length).to eq(1)
      expect(json['data'][0]['id']).to eq idea.id
      expect(json['data'][0]['category']).to eq idea.category.name
      expect(json['data'][0]['body']).to eq idea.body
    end
    it '存在しないcategory_nameで、取得失敗し、ステータスコード404が返ってくる' do
      ideas
      get ideas_path, params: { category_name: Faker::Lorem.characters(number: 10) }
      expect(response.status).to eq(404)
    end
  end
end
