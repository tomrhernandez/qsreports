class StoresController < ApplicationController
  before_action :set_store,         only: [:show, :update, :edit]
  before_action :require_user,      only: [:index, :edit, :update, :new, :show]
  before_action :set_no_cache,      only: [:index, :edit, :update, :new, :show]
  before_action :require_same_user, only: [:edit, :update, :show], :unless => :current_user_is_admin
  before_action :current_user_is_admin, only: [:edit, :update, :new, :create, :destroy]
  
  
  # Get store object ready for creation.
  def new
    @users = User.all
    @store = Store.new
  end
  
  #def create
  #  logger.warn "*** BEGIN RAW REQUEST HEADERS ***"
  #    self.request.env.each do |header|
  #      logger.warn "#{header[0]}:#{header[1]}"
  #      #logger.warn "#{header[1]}"
  #    end
  #  logger.warn "*** END RAW REQUEST HEADERS ***"
  #  
  #end
  
  def destroy
    Store.find(params[:id]).delete
    flash[:success] = "Store Deleted"
    redirect_to admin_path
  end
  
  # Create new store.
  def create
    @users = User.all
    @store = Store.new(store_params)
    if @store.save
      flash[:success] = "Store Created"
      redirect_to edit_store_path(@store)
    else
      render 'new'
    end
  end
  
  def admin
    @stores = Store.all
    @users = User.all
  end
  
  # Store listing, find messages in date range.
  def index
    @stores = current_user.stores
    #@stores = Store.all
    #@search = MessageSearch.new(params[:search])
    #@messages = @search.scope
  end
  
  def show
    @store = Store.find(params[:id])
    #@reports = @store.reports
    #@reports = @store.reports.group_by {|m| m.report_date.beginning_of_month}
    @reports = @store.reports.group_by {|m| m.report_date}
  end
  
  # Edit a store.
  def edit
    @store = Store.find(params[:id])
    @users = User.all
    #@store = Store.second
  end
  
  # Update existing store.
  def update
    @store = Store.find(params[:id])
    @users = User.all
    @store.update(store_params)
    flash[:success] = "Store Updated"
    redirect_to edit_store_path(@store)
  end
  
  # Find by NABP number, check for API key and secret, only show incoming messages.
  def inbox
    if Store.verify_key_and_secret(params[:api_key], params[:api_secret])
      @store = Store.find_by(nabp: params[:nabp])
      if @store.nil?
       render :text => "Store with that nabp #{params[:nabp]} number not found" and return
      else
        @messages = @store.messages
        render layout: false
      end
    else
      render :text => "API Key and secret not valid"
    end
    #render layout: false
  end
  
  private
  
  def set_store
    @store = Store.find(params[:id])
  end
  
  def store_params
      params.require(:store).permit(:name, :nabp, {user_ids:[]} )
  end
  
  def require_same_user
    #if current_user != @store.users
    if !@store.users.include? current_user
      flash[:danger] = "You are not permitted to view that store"
      redirect_to stores_path
    end
  end
  
  def current_user_is_admin
    current_user.admin?
  end
  
end
