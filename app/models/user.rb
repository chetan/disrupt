
class User < ActiveRecord::Base

	has_many :friends, :class_name => "User", :finder_sql =>
        'SELECT * FROM users WHERE users.id IN (SELECT friend_id FROM friends WHERE friends.user_id = #{id})'

  has_many :rankings

  def facebook_photo
    GlobalData.fbgraph.get_picture(self.facebook_id)
  end

end
