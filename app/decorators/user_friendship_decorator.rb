class UserFriendshipDecorator < Draper::Decorator
  delegate_all
  #if a method doesn't exist in the decorator, try it on the model 
  decorates :user_friendship
  #deligate_all fixes an error: unindentified method 'required?'

  def friendship_state
  	#titleize makes the first letter of every word in the string uppercased
  	model.state.titleize
  end

  def sub_message
  	case model.state
  	when 'pending'
  		"Friend request pending."
  	when 'accepted'
  		"You are friends with #{model.friend.first_name}!"
  	end
  end

  def update_action_verbiage
    case model.state
    when 'pending'
      'Delete'
    when 'requested'
      'Accept'
    when 'accepted'
      'Update'
    when 'blocked'
      'Unblock'
    end
  end









  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
