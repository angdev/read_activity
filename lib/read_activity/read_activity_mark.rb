class ReadActivityMark < ActiveRecord::Base
  belongs_to :readable, polymorphic: true

  enum mark: [ :no_mark, :reader_creation_mark, :prev_all_read_mark ]
end