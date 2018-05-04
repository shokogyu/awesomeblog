module UsersHelper

	def gravatar_for(user, size=80) # 80はデフォルト値、paramで指定忘れたときにエラーになる
	gravatar_id = Digest::MD5::hexdigest(user.email)
	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	image_tag(gravatar_url, alt: user.name)		
	end

end