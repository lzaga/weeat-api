require 'rails_helper'
require ‘rake’

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
end
