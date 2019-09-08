require 'spec_helper'
require 'rake'

describe 'fetch_restaurants_from_zomato' do
  before(:all) do
    Rake.application.rake_require("../../lib/tasks/fetch_restaurants_from_zomato")
    Rake::Task.define_task(:environment)
  end

  before(:each) do
    Review.delete_all
    Restaurant.delete_all
  end

  describe "test rake task" do
    let :run_rake_task do
      Rake::Task["fetch_restaurants_from_zomato"].reenable
      Rake.application.invoke_task "fetch_restaurants_from_zomato"
    end

    it "should save new restaurants" do
      expect { run_rake_task }.to change { Restaurant.count }
    end

    it "should save new reviews" do
      expect { run_rake_task }.to change { Review.count }
    end

    context 'errors' do
      it "raises error if restaurant did not save" do
        allow(Restaurant).to receive(:find_or_create_by).and_raise(ActiveRecord::ActiveRecordError)

        run_rake_task

        expect { run_rake_task }.not_to change { Restaurant.count }
      end
    end
  end
end