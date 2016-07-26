require 'byebug'
post '/answer' do
	if logged_in?
		answer = Answer.answer(params["answer"]["question_id"], session[:id], params["answer"]["answer"])
		redirect to '/question/' + answer.question_id.to_s
	else
		@message = "Please log in first"
		erb :'sessions/new'
	end
end

get '/answer/:id/edit' do # return form to edit answer
	@answer = Answer.find(params[:id])
	erb :'answers/edit'
end

put '/answer/:id' do # update answer
	answer = Answer.find(params[:id])
	answer.update(params[:answer])
	redirect to '/question/' + answer.question_id.to_s
end

delete '/answer/:id' do # delete answer
	answer = Answer.find(params[:id])
	Answer.find(params[:id]).destroy
	redirect to '/question/' + answer.question_id.to_s
end