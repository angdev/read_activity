module ReadActivity
  module Reader
    class << self
      attr_accessor :klass
      def register_klass(klass)
        @klass = klass
      end
    end

    module ClassMethods
      def find_who_read(readable)
        self.joins(:read_activity_marks).merge(ReadActivityMark.where(readable: readable))
      end
    end

    module InstanceMethods
      # inverse of Readable#read_by!
      def read_as_mark!(readable)
        readable.read_by!(self)
      end

      # inverse of Readable#read_by?
      def read_as_mark?(readable)
        readable.read_by?(self)
      end

      def read_readables(klass)
        klass.send(:find_read_by, self)
      end

    end
  end
end