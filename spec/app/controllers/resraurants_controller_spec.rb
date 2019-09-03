require 'rails_helper'

RSpec.describe RestaurantsController, :type => :controller do
  before(:all) do
    @restaurants = FactoryBot.create_list(:restaurant, 3)
  end

  describe '#index' do
    it 'returns array with restaurants' do
      get :index

      formatted_response = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(formatted_response).to be_an_instance_of(Array)
      expect(formatted_response.length).to be >(2)
    end
  end

  describe '#show' do
    it 'returns specific restaurant by id' do
      get :show, params: { id: @restaurants[0].id }

      expect(response.status).to eq(200)
      expect(response.body).not_to be_empty
    end

    context  'restaurant does not exist' do
      it 'returns 404 not found' do
        expect{ get :show, :params => { id: :not_exist } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#create' do
    it 'creates new restaurant' do
      new_name = Faker::Name.name
      post :create, :params => { restaurant: { name: new_name, cuisine: 'Italian', ten_bis: true, address: Faker::Address.full_address, max_delivery_time: Faker::Number.between(from: 1, to: 120), rating: Faker::Number.between(from: 1, to: 3) }}

      expect(response.status).to eq(201)
      expect(response.body).not_to be_empty

      formatted_response = JSON.parse(response.body)

      expect(Restaurant.find_by(id: formatted_response['id'])).to be_present
    end
  end

  describe '#update' do
    describe 'restaurant exists' do
      it 'updates name field' do
        new_name = Faker::Name.name
        post :update, :params => { id: @restaurants[0].id, restaurant: { name: new_name }}

        expect(response.status).to eq(200)
        expect(response.body).not_to be_empty

        expect(Restaurant.find_by(id: @restaurants[0].id).name).to eq(new_name)
      end
    end

    describe 'restaurant does not exist' do
      it 'returns 404' do
        expect{ post :update, :params => { id: :not_exist, name: Faker::Name.name } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#destroy' do
    describe 'restaurant exists' do
      it 'deletes the restaurant' do
        post :destroy, :params => { id: @restaurants[0].id}

        expect(response.status).to eq(204)
        expect(Restaurant.find_by(id:  @restaurants[0].id)).not_to be_present
      end
    end

    describe 'restaurant does not exist' do
      it 'returns 404' do
        expect{ post :destroy, :params => { id: :not_exist } }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
