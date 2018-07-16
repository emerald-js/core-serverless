
export default class Response

	constructor:(@status = 200, @body = '', @headers = {})->

	set:(header, value)->
		@headers[header] = value
		return @

	json:(content)->
		@body = JSON.stringify content
		return @
