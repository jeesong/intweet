module UsersHelper

  # Returns gravatar for the user
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def jeevatar_for(user, size)
    image_tag("gravatar/#{user.avatar}.jpg", alt: user.name, class: "gravatar", size: "#{size}")
  end
end
