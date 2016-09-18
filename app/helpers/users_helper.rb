module UsersHelper
  def gravatar_for user
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag gravatar_url, alt: user.fullname, class: "gravatar"
  end

  def display_activity activity
  	unless (["follow", "unfollow"].include?(activity.action_type)) && (User.find_by(id: activity.target_id).nil?)
  	  render "/users/activity", activity:activity
  	end
  end
end
