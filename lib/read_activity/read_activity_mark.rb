class ReadActivityMark < ActiveRecord::Base
  belongs_to :readable, polymorphic: true
end