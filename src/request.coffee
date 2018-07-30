
export default class Request

	constructor:(@event, @context) ->

		@method 	= @event.httpMethod
		@path 		= @event.path
		@headers 	= @event.headers
		@params		= @event.pathParameters
		@query		= @event.queryStringParameters
		@body		= @event.body

		# Object.freeze @

	json: ->
		if !@jsonBody_
			@jsonBody_ = JSON.parse @body

		return @jsonBody_
