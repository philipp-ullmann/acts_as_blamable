$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'active_record'
require 'acts_as_blamable'
require 'spec'
require 'spec/autorun'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

def setup_db
  ActiveRecord::Schema.define(:version => 1) do
    create_table :users do |t|
      t.string :name
    end
    
    create_table :posts do |t|
      t.integer :created_by, :updated_by
      t.text :content
    end
    
    create_table :people do |t|
      t.string :name
    end
    
    create_table :comments do |t|
      t.integer :creator_id, :updater_id
      t.text :content
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table table
  end
end

class User < ActiveRecord::Base
  def self.current_user
    User.first
  end
end

class Post < ActiveRecord::Base
  acts_as_blamable
end

class Person < ActiveRecord::Base
  def self.current_person
    Person.first
  end
end

class Comment < ActiveRecord::Base
  acts_as_blamable :class_name => 'Person', :creator_foreign_key => :creator_id, :updater_foreign_key => :updater_id, :current_user_method => 'current_person'
end

Spec::Runner.configure do |config|
end
