module ReadActivity
  module Readable
    @klasses = []
    class << self
      attr_accessor :klasses
      def register_klass(klass)
        @klasses << klass
      end
    end

    module ClassMethods
      def find_read_by(reader)
        self.joins(:read_activity_marks).merge(ReadActivityMark.where(reader: reader))
      end
    end

    module InstanceMethods
      def read_by!(reader)
        ReadActivityMark.transaction do
          mark = self.read_activity_marks.build(reader: reader)
          mark.save!
        end
      end

      def read_by?(reader)
        mark = self.read_activity_marks.where(reader: reader)
        mark.exists?
      end

      def readers
        Reader.klass.send(:find_who_read, self)
      end
    end
  end
end