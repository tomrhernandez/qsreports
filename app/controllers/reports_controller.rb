class ReportsController < ApplicationController
    before_action :current_user_is_admin, only: [:edit, :update, :new, :create, :destroy]

    
    def create
        @store = Store.find_by(nabp: params[:nabp])
        @report = Report.new({:filename => params[:filename], :display_name => params[:display_name], :store_id => @store.id, :report_date => params[:report_date]})
        if @report.save
            render :text => "Report saved"
        else
            @report.errors.each do |attribute, message|
                render :text => "ERROR: #{message} trying to save \"#{attribute}\""
            end
        end
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
        params.require(:report).permit(:filename, :display_name, :store_id, :report_date)
    end
    
    def current_user_is_admin
        current_user.admin?
    end
    
end
