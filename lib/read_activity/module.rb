module ReadActivity
  def self.included(base)
    base.extend Module
  end

  module Module
    def acts_as_reader
      ReadActivityMark.belongs_to :reader, class_name: self.to_s
      has_many :read_activity_marks, foreign_key: "reader_id", dependent: :delete_all

      extend Reader::ClassMethods
      include Reader::InstanceMethods
    end

    def acts_as_readable
      has_many :read_activity_marks, as: :readable

      extend Readable::ClassMethods
      include Readable::InstanceMethods
    end
  end
end