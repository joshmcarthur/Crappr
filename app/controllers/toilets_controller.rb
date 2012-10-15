class ToiletsController < ApplicationController
  respond_to :html, :js, :mobile
  before_filter :load_toilet, :except => [:index]
  
  def index
    @toilets = Toilet.all.limit(params[:limit] || nil)
    respond_to do |format|
      format.mobile { render :template => 'toilets/mobile/index' }
      format.json { render :json => @toilets.as_json }
      format.all
    end
  end

  def show
    @near_toilets = Toilet.near(:origin => @toilet, :within => 0.5).order("distance asc")
    @reviews = @toilet.reviews.order('created_at desc').paginate(:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.mobile { render :template => 'toilets/mobile/show' }
      format.json { render :json => @toilet.as_json }
      format.all
    end
  end
  
  def rate
    @toilet.reviews.create :value => params[:rating]
  end
  
  private
  
  def load_toilet
    @toilet = Toilet.find(params[:id])
  end

end
