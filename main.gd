extends Node

const ClientID:String = "3hofk5upx3gzrq1r33scysd6qmux6b"
const Url:String = "http://localhost:8080"
const Scopes:String = "channel%3Amanage%3Apolls+channel%3Aread%3Apolls"
const Uri:String = "https://id.twitch.tv/oauth2/authorize?response_type=token&redirect_uri=" + Url + "&scope=" + Scopes + "&client_id=" + ClientID

@export var twitch_auth_link:LinkButton
@export var FAM_on_off:CheckButton ## NOTE this is just while testing (PD: FAM = FullActionsMenu)
@export var full_actions_menu:Window

var http_server = HttpServer.new()
var main_router = MainRouter.new()

#region main
func _ready() -> void:
	if full_actions_menu:
		full_actions_menu.close_requested.connect(_on_full_actions_menu_close_requested)
	
	if twitch_auth_link:
		twitch_auth_link.uri = Uri
		
		main_router.post_request.connect(_on_post_request)
		
		http_server.register_router("/", main_router)
		add_child(http_server)
		http_server.enable_cors([Url])
	

func _process(delta) -> void:
	pass
#endregion
#region signals
func _on_post_request(body) -> void:
	print(body)

func _on_check_button_toggled(toggled_on) -> void:
	if toggled_on:
		http_server.start()
	else:
		http_server.stop()

func _on_window_on_off_toggled(toggled_on) -> void:
	full_actions_menu.set_visible(toggled_on)

func _on_full_actions_menu_close_requested() -> void:
	# full_actions_menu.hide() ## NOTE TODO uncomment this line-
	if FAM_on_off: # and erase this "if" when FAM_on_off var is no longer needed
		FAM_on_off.set_pressed(false)

#endregion
