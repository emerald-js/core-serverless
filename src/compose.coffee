
export default (middleware) ->

	if not Array.isArray middleware
		throw new TypeError 'Middleware stack must be an array!'

	middleware = middleware.map (fn) ->
		switch typeof fn

			when 'function'
				return fn

			when 'object'
				if typeof fn.handle is 'function'
					return fn.handle.bind fn

		throw new TypeError 'Middleware must be composed of functions or handle objects!'

	return (params...) ->

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
				return Promise.resolve fn.apply null, [
					...params
					dispatch.bind null, i + 1
				]

			catch error
				return Promise.reject error

		return dispatch 0
