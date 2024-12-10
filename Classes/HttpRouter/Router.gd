class_name MainRouter extends HttpRouter

signal post_request(body:String)

var get_request_main_script:String = load_from_file("res://Classes/HttpRouter/get_request_main_script.js")

#region TODO please turn these things into global functions
func load_from_file(path:String) -> String:
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return content
#endregion

# Handle a GET request
func handle_get(request: HttpRequest, response: HttpResponse):
	response.send(200, "
	<html>
		<body>
			<h1>Hello! from GET</h1>
			<script>" + get_request_main_script + "</script>
		</body>
	</html>
	")
	print("Hello! from GET")
	print(HttpResponse)

# Handle a POST request
func handle_post(request: HttpRequest, response: HttpResponse) -> void:
	var _parsed_body = request.get_body_parsed()
	response.send(200, JSON.stringify({
		message = "Hello! from POST",
		raw_body = request.body,
		parsed_body = _parsed_body,
		params = request.query
	}), "application/json")
	post_request.emit(_parsed_body)
	print("Hello! from POST")

# Handle a PUT request
func handle_put(request: HttpRequest, response: HttpResponse) -> void:
	response.send(200, "Hello! from PUT")
	print("Hello! from PUT")

# Handle a PATCH request
func handle_patch(request: HttpRequest, response: HttpResponse) -> void:
	response.send(200, "Hello! from PATCH")
	print("Hello! from PATCH")

# Handle a DELETE request
func handle_delete(request: HttpRequest, response: HttpResponse) -> void:
	response.send(200, "Hello! from DELETE")
	print("Hello! from DELETE")
