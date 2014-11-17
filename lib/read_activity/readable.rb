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
        self.includes(:read_activity_marks).merge(ReadActivityMark.where(reader: reader)).references(:read_activity_marks)
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
          mark = self.read_activity_marks.where(reader: reader).first_or_initialize
          mark.save!
        end
      end

      def read_by?(reader)
        mark = self.read_activity_marks.exists?(reader: reader)
      end

      def read_by_at(reader = nil)
        read_by_at = nil

        if self.read_activity_marks.loaded?
          read_by_at = self.read_activity_marks.first.try(:created_at)
        end

        if read_by_at.nil? && reader
          if reader.read_activity_marks.loaded?
            read_by_at = reader.read_activity_marks.first.try(:created_at)
          else
            read_by_at = self.read_activity_marks.where(reader: reader).first.try(:created_at)
          end
        end

        return read_by_at
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
