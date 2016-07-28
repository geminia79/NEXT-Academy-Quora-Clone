require 'byebug'
get '/users/:id' do
	@questions = current_user.questions
	@answers = current_user.answers
	erb :'users/show'
end

get '/users/:id/edit' do
	erb :'users/edit'
end

put '/users/:id' do
	user = current_user
	user.update(params[:user])
	if user.valid?
		@message = "Profile Updated"
		@questions = current_user.questions
		@answers = current_user.answers
		erb :'/users/show'
	else
		@message = "Invalid Input, Profile not being updated"
		erb :'/users/edit'
	end
end







