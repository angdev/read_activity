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

      def find_who_unread(readable)
        self.joins(%Q(
          LEFT OUTER JOIN
          (SELECT * FROM read_activity_marks WHERE readable_id = #{readable.id}) AS readable_marks
          ON readable_marks.reader_id = #{self.table_name}.id
        )).where("readable_marks.reader_id IS NULL")
      end
    end

    module InstanceMethods
      # inverse of Readable#read_by!
      def read!(readable)
        readable.read_by!(self)
      end

      # inverse of Readable#read_by?
      def read?(readable)
        readable.read_by?(self)
      end

      def readables_marked_as_read(klass)
        klass.send(:find_read_by, self)
      end

      def readables_unmarked_as_read(klass)
        klass.send(:find_unread_by, self)
      end

      def method_missing(method, *arguments, &block)
        if method.to_s =~ /^read_(.*)/
          readables_marked_as_read($1.singularize.camelize.constantize, *arguments, &block)
        elsif method.to_s =~ /^unread_(.*)/
          readables_unmarked_as_read($1.singularize.camelize.constantize, *arguments, &block)
        else
          super
        end
      end

      def respond_to_missing?(method, include_private = false)
        method_name = method.to_s
        if method_name.start_with?("read_") or method_name.start_with?("unread_")
          true
        else
          super
        end
      end
    end
  end
end