require 'sinatra'
require 'sinatra/reloader' if development?

get '/add' do
  erb(:add)
end

post '/calculate_add' do

end