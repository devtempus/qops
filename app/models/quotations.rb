class Quotations < ActiveRecord::Base
  validates_presence_of :full_text
end
