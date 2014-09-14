require "rails/generators"
require "rails/generators/migration"

class ReadActivityGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_migration_file
    migration_template "create_read_activity_marks.rb", "db/migrate/create_read_activity_marks.rb"
  end
end
