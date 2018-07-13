
handleError = (error, context, response) ->
	if error instanceof ViewableError
		return {
			statusCode: error.status
			headers: {
				'content-type': 'application/json'
			}
			body: JSON.stringify {
				errors: [
					{
						code: 		error.code
						message: 	error.message
					}
				]
			}
		}
	else
		throw error


export default (handle) ->
	return (event, context) ->

		request.event 	= event
		request.context = context

		request.headers = event.headers
		request.params 	= event.pathParameters
		request.query 	= event.queryParameters
		request.body 	= event.body

		response = {
			status: 200
			body: ''
			headers: {}
		}

		try
			handle request, response

		catch error
			return handleError error, context, response

		if response.json
			response.body = JSON.stringify response.json
			response.headers['content-type'] = 'application/json'

		return {
			headers: 		response.headers
			statusCode: 	response.status
			body: 			response.body
		}
