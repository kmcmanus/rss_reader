class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @subscriptions = current_user.subscriptions
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.create!
    if @subscription.update_attributes(params['subscription'])
      @subscription.load_base_data
      @subscription.save!
      current_user.subscriptions << @subscription
      redirect_to :action => 'index'
    else
      redirect_to :action => 'edit'
    end
  end
end
