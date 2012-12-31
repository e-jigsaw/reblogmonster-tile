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
					output += "<binding template='tile'>"
					if post.type is "photo"
						output += "<type>photo</type>"
						output += "<image src='#{post.photos[0].alt_sizes[1].url}' />"
						output += "<notes>#{post.note_count}</notes>"
						output += "</binding>"
					else if post.type is "text"
						output += "<type>text</type>"
						output += "<text>#{post.body}</text>"
						output += "<notes>#{post.note_count}</notes>"
						output += "</binding>"
					else if post.type is "quote"
						output += "<type>quote</type>"
						output += "<quote>#{post.text}</quote>"
						output += "<notes>#{post.note_count}</notes>"
						output += "</binding>"

			output += "</visual></title>"
			res.type "xml"
			res.send output
		)
