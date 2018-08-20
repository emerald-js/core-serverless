
import compose from './compose'

export default (middlewares...) ->

	fn = compose middlewares

	return (input, context) ->

		return await fn {
			input
			context
		}
