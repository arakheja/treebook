module PicturesHelper
	#if the user is signed in and the current_user is associated with the picture
	def can_edit_picture?(picture)
		signed_in? && current_user == picture.user
	end
end
