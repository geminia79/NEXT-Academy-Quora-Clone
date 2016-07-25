get '/sessions/new' do
	erb :"sessions/new"
end

post '/sessions' do
	user = User.authentication(params["user"]["email"], params["user"]["password"])
	if user != nil
		session[:id] = user.id
		redirect '/'
	else
		@message = "Invalid email or password"
		erb :"sessions/new"
	end
end

post '/signup' do
	user = User.new(params["user"])
	if user.valid?
		user.save
		session[:id] = user.id
		redirect '/'
	else
		@message = user.errors.full_messages
		erb :"sessions/new"
	end
end

post '/login' do
	erb :"sessions/new"
end

post '/logout' do
	session[:id] = nil
	redirect '/'
end