export default (middleware) ->

	if not Array.isArray middleware
		throw new TypeError 'Middleware stack must be an array!'

	for fn in middleware
		if typeof fn isnt 'function'
			throw new TypeError 'Middleware must be composed of functions!'

	return (request, response, next) ->

		index = -1

		dispatch = (i) ->
			if i <= index
				return Promise.reject new Error 'next() called multiple times'

			index = i
			fn = middleware[i]

			if i is middleware.length
				fn = next

			if !fn
				return Promise.resolve()

			try
				return Promise.resolve fn(
					request
					response
					dispatch.bind null, i + 1
				)

			catch error
				return Promise.reject error

		return dispatch 0
