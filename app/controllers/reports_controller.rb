class ReportsController < ApplicationController
    
    #https://marqpdfapp-tomrhernandez.c9users.io/reports|&filename=1140083_reports_20171103.pdf&display_name=January%20Low%202018&nabp=1112072&report_date=2017-01-01
    
    
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
    
    private
    
    #def report_params
    #    params.require(:report).permit(:filename, :display_name, :store_id, :report_date)
    #end
end
