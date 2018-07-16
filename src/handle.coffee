
import Request 			from './request'
import Response 		from './response'
import ViewableError 	from './error/viewable-error'

handleError = (error, context, response) ->

	if error instanceof ViewableError
		return {
			statusCode: error.status
			headers: {
				'content-type': 'application/json'
			}
			body: JSON.stringify {
				code: 		error.code
				message: 	error.message
			}
		}
	else
		throw error

export default (handle) ->

	return (event, context) ->

		request 	= new Request event, context
		response 	= new Response

		try
			await handle request, response

		catch error
			return handleError error, context, response

		return {
			headers: 		response.headers
			statusCode: 	response.status
			body: 			response.body
		}
