require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
set :database, { adapter: "sqlite3", database: "mydb.db" }
require './models/user'
require './models/team'

get '/' do
    User.all.to_yaml + Team.all.to_yaml
end

get "/which_user" do
  @users = User.all
  erb :which_user
end

get '/users1' do
    @users = User.all
    erb :users1
end

get '/users2' do
    @users = User.all
    erb :users2
end

post '/show_user' do
    @user = User.find_by(name: params[:name])
    if @user.nil?
        return "User not found."
    end
    erb :user
end

get '/user/:id' do
    @user = User.find(params[:id])
    if @user.nil?
        return "User not found."
    end
    erb :user
end
