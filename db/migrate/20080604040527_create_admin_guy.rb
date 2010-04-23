class CreateAdminGuy < ActiveRecord::Migration
  def self.up
    user = User.new( :name => 'Codevader', :email => 'mauricio@gmail.com', :login => 'codevader' )
    user.password = 'codevader-admin'
    user.password_confirmation  = 'codevader-admin'
    user.is_admin = true
    user.save!
  end

  def self.down
    
    User.delete_all
    
  end
end
