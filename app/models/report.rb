class Report < ActiveRecord::Base
  belongs_to :store
  
  
  validates :filename, :display_name, :report_date, :presence => {:message => "Empty value found!"}

end
