module ReadActivity
  module Reader
    module ClassMethods

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
    end
  end
end