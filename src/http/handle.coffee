
import compose 		from '../compose'
import Request 		from './request'
import Response 	from './response'

export default (middlewares...) ->

	fn = compose middlewares

	return (event, context) ->
		request 	= new Request event, context
		response 	= new Response

		await fn request, response

		return {
			headers: 		response.headers
			statusCode: 	response.status
			body: 			response.body
		}
