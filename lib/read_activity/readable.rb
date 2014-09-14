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
    end
  end
end