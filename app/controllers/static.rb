require 'byebug'
get '/' do
  erb :"static/home"
end

get '/main' do
	erb :"static/index"
end

post '/signup' do
	user = User.new(params["user"])
	if user.valid?
		user.save
		redirect '/'
	else
		session[:error] = user.errors.full_messages
		redirect '/'
	end
end

post '/login' do
	user = User.find_by(email: params["user"]["email"])
	if user and user.authenticate(params["user"]["email"])
		session[:id] = user.id
		redirect '/main'
	else
	end

end
