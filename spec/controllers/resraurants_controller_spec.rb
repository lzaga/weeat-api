require 'rails_helper'

RSpec.describe RestaurantsController, :type => :controller do
  before(:all) do
    @restaurants = FactoryBot.create_list(:restaurant, 3)
  end

  describe 'GET restaurants' do
    it 'returns array with restaurants' do
      get :index

      expect(response.status).to eq(200)
      expect(response.body).not_to be_empty
    end
  end

  describe 'GET reviews#1' do
    it 'returns specific restaurant by id' do
      get :show, :params => { id: @restaurants[0].id }

      expect(response.status).to eq(200)
      expect(response.body).not_to be_empty
    end

    context  'restaurant does not exist' do
      it 'returns 404 not found' do
        expect{ get :show, :params => { id: :not_exist } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST review' do
    it 'creates new restaurant' do
      post :create, :params => { name: 'New Rest', cuisine: 'Italian', ten_bis: true, address: 'Some Address', max_delivery_time: 30, rating: 0 }

      expect(response.status).to eq(201)
      expect(response.body).not_to be_empty

      formatted_response = JSON.parse(response.body)

      get :show, :params => { id: formatted_response["id"] }
      expect(response.status).to eq(200)
      expect(response.body).not_to be_empty
    end
  end

  describe 'PATCH review' do
    describe 'restaurant exists' do
      it 'updates name field' do
        post :update, :params => { id: @restaurants[0].id, name: 'New Name' }

        expect(response.status).to eq(200)
        expect(response.body).not_to be_empty

        get :show, :params => { id: @restaurants[0].id }
        formatted_response = JSON.parse(response.body);
        expect(formatted_response["name"]).to eq('New Name')
      end
    end

    describe 'restaurant does not exist' do
      it 'returns 404' do
        expect{ post :update, :params => { id: :not_exist, name: 'new_name' } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE review' do
    describe 'restaurant exists' do
      it 'updates name field' do
        post :destroy, :params => { id: @restaurants[0].id}

        expect(response.status).to eq(204)
        expect(response.body).to be_empty
      end
    end

    describe 'restaurant does not exist' do
      it 'returns 404' do
        expect{ post :destroy, :params => { id: :not_exist } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
