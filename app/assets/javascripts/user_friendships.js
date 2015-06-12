window.userFriendships = [];

$(document).ready(function() {
	$.ajax({
		url: Routes.user_friendships_path({format: 'json'}),
		dataType: 'json',
		type: 'GET',
		success: function(data) {
			window.userFriendships = data;
		}
	});
	
	$('#add-friendship').click(function(event) {
		event.preventDefault();
		var addFriendshipBtn = $(this);
		// AJAX request to a user friendship path, as a 'POST' with a dataType of 'json'.
		$.ajax({
			url: Routes.user_friendships_path({user_friendship: { friend_id: addFriendshipBtn.data('friendId') }}),
			dataType: 'json',
			type: 'POST',
			// If it is successful we hide the FriendshipBtn which we assigned above
			success: function(e) {
				addFriendshipBtn.hide();
				// We append another button saying that we requested the friendship
				$('#friend-status').html("<a href='#' class='btn btn-success'>Friendship Requested</a>");
			}
		});
	});

});