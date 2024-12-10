extends Node

const ClientID:String = "3hofk5upx3gzrq1r33scysd6qmux6b"
const Url:String = "http://localhost:8080"
const Scopes:String = "channel%3Amanage%3Apolls+channel%3Aread%3Apolls"
const Uri:String = "https://id.twitch.tv/oauth2/authorize?response_type=token&redirect_uri=" + Url + "&scope=" + Scopes + "&client_id=" + ClientID

@onready var TwitchAuthLink:LinkButton = $Control/GridContainer/LinkButton

var http_server = HttpServer.new()
var main_router = MainRouter.new()

func _ready() -> void:
	TwitchAuthLink.uri = Uri
	
	main_router.post_request.connect(_on_post_request)
	
	http_server.register_router("/", main_router)
	add_child(http_server)
	http_server.enable_cors([Url])
	


func _process(delta) -> void:
	pass

func _on_post_request(body):
	print(body)

func _on_check_button_toggled(toggled_on):
	if toggled_on:
		http_server.start()
	else:
		http_server.stop()
