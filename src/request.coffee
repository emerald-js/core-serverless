
import ViewableError from './error/viewable-error'

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

			try
				@jsonBody_ = JSON.parse @body
			catch
				throw new ViewableError 'Malformed JSON in request body'

		return @jsonBody_
