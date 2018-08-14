
import ViewableError 	from '../error/viewable-error'
import compose 			from '../compose'
import Request 			from './request'
import Response 		from './response'

handleError = (error, response) ->
	if error instanceof ViewableError or error.viewable

		response.status = error.status
		response.json {
			code: 		error.code
			message: 	error.message
		}

	else
		throw error

export default (middlewares...) ->

	fn = compose middlewares

	return (event, context) ->

		request 	= new Request event, context
		response 	= new Response

		try
			await fn request, response

		catch error
			handleError error, response

		return {
			headers: 		response.headers
			statusCode: 	response.status
			body: 			response.body
		}
