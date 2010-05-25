module ActsAsBlamable
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def acts_as_blamable(options={})
      class_variable_set :@@bl_conf, { :current_user_method => :current_user, :class_name => 'User', :creator_foreign_key => :created_by, :updater_foreign_key => :updated_by }
      bl_conf.update(options) if options.is_a? Hash
      
      class_eval do
        include ActsAsBlamable::InstanceMethods
        
        belongs_to :creator, :foreign_key => bl_conf[:creator_foreign_key], :class_name => bl_conf[:class_name]
        belongs_to :updater, :foreign_key => bl_conf[:updater_foreign_key], :class_name => bl_conf[:class_name]
        
        before_create :save_creator
        before_update :save_updater
      end
    end
    
    def bl_conf
      class_variable_get :@@bl_conf
    end
  end
  
  module InstanceMethods
    private
    
    def save_creator
      self.creator = current_user
    end
    
    def save_updater
      self.updater = current_user
    end
    
    def current_user
      self.class.bl_conf[:class_name].constantize.send("#{self.class.bl_conf[:current_user_method]}")
    end
  end
end

ActiveRecord::Base.class_eval { include ActsAsBlamable }
