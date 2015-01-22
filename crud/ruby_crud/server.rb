require 'sinatra'
require 'json'
require 'pry'

pets = []

get '/create/:pet_name/:pet_type' do 
	content_type :json
	pet_name = params[:pet_name]
	pet_type = params[:pet_type]
	data = {
		pet_name: pet_name,
	 	pet_type: pet_type
	}
	pets.push(data)
	data.to_json
end


get '/read/:pet_name' do
	content_type :json
	pet_name = params[:pet_name]

	data = {}
	pets.each do |each|
		if each[:pet_name] == pet_name
			data = each
		end
	end
	# pets[0][:pet_name]
	if data == {}
		data = {nope: "That is not a pet!"}
	end

	data.to_json
end

get '/update/:pet_name/:new_pet_name' do
	content_type :json
	pet_name = params[:pet_name]
	new_pet_name = params[:new_pet_name]

	data = {}

	pets.each do |each|
		if each[:pet_name] == pet_name
			each[:pet_name] = new_pet_name
			data = {success: "You've Changed their Name!"}
		end
	end

	if data == {}
		data = {nope: "That is not a pet!"}
	end
	data.to_json
end


get '/destroy/:pet_name' do
	content_type :json

	pet_name = params[:pet_name]
	new_pet_name = params[:new_pet_name]

	data = {}

	i = 0
	pets.each do |each|
		if each[:pet_name] == pet_name
			pets.delete_at(i)
			data = {success: "You've Destroyed This Pet!"}
		end
		i+=1
	end
	
	if data == {}
		data = {nope: "That is not a pet!"}
	end
	data.to_json
end


get "/all_pets" do
	content_type :json
	pets.to_json
end

