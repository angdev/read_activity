module ReadActivity
  def self.included(base)
    base.extend Module
  end

  module Module
    def acts_as_reader
      extend Reader::ClassMethods
      include Reader::InstanceMethods
    end

    def acts_as_readable
      extend Readable::ClassMethods
      include Readable::InstanceMethods
    end
  end
end