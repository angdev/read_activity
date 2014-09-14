module ReadActivity
  def self.included(base)
    base.extend Module
  end

  module Module
    def acts_as_reader
      extend Reader::ClassMethods
      include Reader::InstanceMethods

      Reader.register_klass(self)

      ReadActivityMark.belongs_to :reader, class_name: self.to_s
      has_many :read_activity_marks, foreign_key: "reader_id", dependent: :delete_all
    end

    def acts_as_readable
      extend Readable::ClassMethods
      include Readable::InstanceMethods

      Readable.register_klass(self)

      has_many :read_activity_marks, as: :readable
    end
  end
end