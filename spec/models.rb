class User < ActiveRecord::Base
  acts_as_reader
end

class Article < ActiveRecord::Base
  acts_as_readable
end