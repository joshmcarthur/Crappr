require 'spec_helper'

describe ToiletsController do
  let(:toilet) { FactoryGirl.create(:toilet) }

  describe "GET index" do
    before do
      get :index
    end

    it { assigns(:toilets).should be_a Array }
    it { response.should render_template :index }
  end

  describe "GET show" do
    before do
      get :show, :id => toilet.id
    end

    it { assigns(:toilet).should eq toilet }
    it { should render_template(:show) }
    it { assigns(:near_toilets).should be_a ActiveRecord::Relation }
    it { assigns(:reviews).should be_a ActiveRecord::Relation }
  end
end