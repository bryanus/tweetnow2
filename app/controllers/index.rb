get '/?' do
  @access_token = @request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session[:oauth][:access_token] = @access_token.token
  puts "*" * 30
  session[:oauth][:access_token_secret] = @access_token.secret

  erb :index
end


post '/tweet' do
  
  tweet = Tweet.create(params)
  Twitter.update(tweet.content)
  "#{tweet.info}"
end  

get '/oauth' do
	@consumer = OAuth::Consumer.new( ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'],
    { :site => "http://api.twitter.com",
      :scheme => :header
    })

	@request_token = session[:request_token]
	@request_token_secret = session[:request_token_secret]

	if @request_token.nil? || @request_token_secret.nil?
		@request_token = @consumer.get_request_token(:oauth_callback => "http://127.0.0.1:9292/oauth")
	  p "1"
	  p session[:request_token] = @request_token.token
	  p "2"
	  p session[:request_token_secret] = @request_token.secret
	  redirect @request_token.authorize_url
	elsif session[:access_token].nil? || session[:access_verifier].nil?	
		p "3"
		p session[:access_token] = params[:oauth_token]
		p "4"
		p session[:access_verifier] = params[:oauth_verifier]
		p @access_token = OAuth::AccessToken.new(@consumer, session[:access_token], session[:access_verifier])
		# @request_token = OAuth::RequestToken.new(@consumer, @request_token, @request_token_secret)
		redirect '/oauth'
	else
    client = Twitter::Client.new(
  		:consumer_key => ENV['TWITTER_KEY'],
  		:consumer_secret => ENV['TWITTER_SECRET'],
  		:oauth_token => session[:access_token],
  		:oauth_token_secret => session[:access_verifier]
		)
		p client.methods.sort
	end

	 

	# @request_token = consumer.get_request_token(:oauth_callback => "http://127.0.0.1:9292/")
 #    session[:oauth][:request_token] = @request_token.token
 #    session[:oauth][:request_token_secret] = @request_token.secret
end  