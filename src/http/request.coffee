
import ViewableError from '../error/viewable-error'

export default class Request

	constructor:(@event, @context) ->

		@method 	= @event.httpMethod 			or ''
		@path 		= @event.path 					or ''
		@headers 	= @event.headers 				or {}
		@params		= @event.pathParameters 		or {}
		@query		= @event.queryStringParameters 	or {}
		@body		= @event.body 					or ''

		# Object.freeze @

	json: ->
		if !@jsonBody_

			try
				@jsonBody_ = JSON.parse @body
			catch
				throw new ViewableError 'Malformed JSON in request body'

		return @jsonBody_
