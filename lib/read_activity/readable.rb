module ReadActivity
  module Readable
    class << self
      attr_accessor :klasses
      def register_klass(klass)
        @klasses ||= []
        @klasses << klass
      end
    end

    module ClassMethods
      def find_read_by(reader)
        self.joins(:read_activity_marks).merge(ReadActivityMark.where(reader: reader))
      end

      def find_unread_by(reader)
        self.joins(%Q(
          LEFT OUTER JOIN
          (SELECT * FROM read_activity_marks WHERE reader_id = #{reader.id}) AS readable_marks
          ON readable_marks.readable_id = #{self.table_name}.id
        )).where("readable_marks.readable_id IS NULL")
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

      def unreaders
        Reader.klass.send(:find_who_unread, self)
      end
    end
  end
end