module ReadActivity
  module Readable
    module ClassMethods

    end

    module InstanceMethods
      def read_by!(reader)
        ReadActivityMark.transaction do
          mark = self.read_activity_marks.build(reader: reader)
          mark.save!
        end
      end

      def read_by?(reader)
        mark = read_activity_marks.where(reader: reader)
        mark.exists?
      end
    end
  end
end