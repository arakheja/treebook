class ProfilesController < ApplicationController

  def show
  	@user = User.find_by_profile_name(params[:id])
  	if @user 
  		@statuses = @user.statuses.all
		  @activities = @user.activities.all
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end

  def page_title
    "RS " + @user.profile_name + "'s profile"
  end

  def page_code
    1
  end

  private

end
