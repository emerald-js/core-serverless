
import Request 			from './request'
import Response 		from './response'
import ViewableError 	from './error/viewable-error'

handleError = (error, context, response) ->

	if error.isJoi
		fields = []
		for detail in error.details
			fields.push {
				message: 	detail.message
				key: 		detail.context.key
			}

		return {
			statusCode: 400
			headers: {
				'content-type': 'application/json'
			}
			body: JSON.stringify {
				code: 		'INPUT_VALIDATION_ERROR'
				message: 	error.details[0].message
				fields
			}
		}

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

export default (middlewares...) ->

	return (event, context) ->

		request 	= new Request event, context
		response 	= new Response

		try for handle in middlewares
			await handle request, response

		catch error
			return handleError error, context, response

		return {
			headers: 		response.headers
			statusCode: 	response.status
			body: 			response.body
		}
