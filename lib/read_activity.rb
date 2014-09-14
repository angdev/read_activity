require "read_activity/version"
require "read_activity/module"
require "read_activity/read_activity_mark"
require "read_activity/reader"
require "read_activity/readable"

ActiveRecord::Base.send :include, ReadActivity