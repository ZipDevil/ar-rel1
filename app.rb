require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
set :database, { adapter: "sqlite3", database: "mydb.db" }
require './models/user'
require './models/team'

get '/' do
    @users=User.all
    erb :user_list
end

get '/' do
    User.all.to_yaml + Team.all.to_yaml
end

get '/new' do
    erb :user_form
end
    
get '/remove' do
    erb :user_delete
end

# add the user returned by user_form and put up a confirmation message.
# Here you would use the Active Record means of inserting a record.
post '/create' do
    # if User.exists?(params[:name])
    # "User is already exist."
    # else
    # User.create!(name: params[:name], email: params[:email])
    # "User #{params[:name]} created!"
    # end
    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.save 
    "User #{params[:name]} created!"
end    

post '/delete' do
    
    user = User.find_by(name: params[:name])
    if user
        user.destroy
        "User #{params[:name]} has been deleted."
    else
        "User not found."
    end
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
