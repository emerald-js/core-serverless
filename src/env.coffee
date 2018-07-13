

export default (name, defaultValue) ->
	value = process.env[name]

	if typeof value is 'undefined'
		return defaultValue

	if value is 'true' or value is 'TRUE'
		return true

	if value is 'false' or value is 'FALSE'
		return false

	if !isNaN value
		return Number value

	if value is 'null' or value is 'NULL'
		return null

	return value
