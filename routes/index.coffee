# GET /

http = require "http"

exports.index = (req, res)->
	http.get "http://api.tumblr.com/v2/blog/#{req.query.url}/posts?api_key=#{process.env.API_KEY}", (r)->
		data = ""
		r.on("data", (c)->
			data += c;
		).on("end", ->
			json = JSON.parse data
			output = "<tile><visual>"
			console.log json
			for post in json.response.posts
				if post.type is "photo" or post.type is "text" or post.type is "quote"
					if post.type is "photo"
						output += "<binding template='TileWideImageAndText01'>"
						output += "<image src='#{post.photos[0].alt_sizes[1].url}' />"
						output += "<text>#{post.note_count}</text>"
						output += "</binding>"
					else if post.type is "text"
						output += "<binding template='TileWideBlockAndText02'>"
						output += "<text>#{post.body}</text>"
						output += "<text>#{post.note_count}</text>"
						output += "</binding>"
					else if post.type is "quote"
						output += "<binding template='TileWideBlockAndText02'>"
						output += "<text>#{post.text}</text>"
						output += "<text>#{post.note_count}</text>"
						output += "</binding>"

			output += "</visual></tile>"
			res.type "xml"
			res.send output
		)
