#-------------------------------------------------------------------------------
# FETCH functions
#-------------------------------------------------------------------------------

def fetch_orders # Michal
	
	@orders = []

	query = "SELECT * FROM Orders WHERE Status = #{ORDER_STATUS_ACTIVE} LIMIT 20;"
	results = @db.execute query

	if results

		results.each do |order|

			@orders.push({

				date: order["Date"].to_s,
				time: order["Time"].to_s,
				from: order["Pickup_location"].to_s,
				to: nil,

				id: order["OrderID"].to_s,
				user_id: order["UserID"].to_s,
				screen_name: order["Twitter_handle"],

# TODO: connect the following property to tweeted orders stored in the database!
				tweets: @twitter.search("from:#{order["Twitter_handle"]} to:#{TEAM_NAME}").take(100)

			})
		end

	else
		redirect '/error'
	end

end

#-------------------------------------------------------------------------------

def fetch_tweets # Michal
	
	results = @twitter.search(TEAM_NAME)
	@tweets = results.take(10)

end

#-------------------------------------------------------------------------------

def fetch_users # Huiqiang
	
    user_id = params[:screen_name]
    @results = @db.execute(
		"SELECT pickup_location, date, time FROM Orders WHERE UserID = ?;",
		[user_id])

end

#-------------------------------------------------------------------------------