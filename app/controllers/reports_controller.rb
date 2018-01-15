class ReportsController < ApplicationController
    before_action :current_user_is_admin, only: [:edit, :update, :destroy, :new]

    
    def create
        @store = Store.find_by(nabp: params[:nabp])
        if @store.nil?
           @store = Store.find(params[:report][:store_id])
           @report = Report.new({:filename => params[:report][:filename], :display_name => params[:report][:display_name], :store_id => @store.id, :report_date => params[:report][:report_date]})
        else
        @report = Report.new({:filename => params[:filename], :display_name => params[:display_name], :store_id => @store.id, :report_date => params[:report_date]})
        end
        if @report.save
            render :text => "Report saved"
        else
            render :text => @report.errors.full_messages
            #@report.errors do |attribute, message|
                #render :text => "ERROR: #{message} trying to save \"#{attribute}\""
                
            #end
            
        end
    end
    
    def new 
        @store = Store.find(params[:id])
        @report = Report.new
    end
    
    def destroy
        Report.find(params[:id]).destroy
        flash[:success] = "Report deleted."
        redirect_to :back
    end
    
    def edit
       @report = Report.find(params[:id])
       @stores = Store.all
    end
    
    def update
        @report = Report.find(params[:id])
        @report.update(report_params)
        flash[:success] = "Report Updated"
        redirect_to :back
    end
    
    
    private
    
    def report_params
        params.require(:report).permit(:filename, :display_name, :store_id, :report_date, :created_at)
    end
    
    def current_user_is_admin
        current_user.admin?
    end
    
end
