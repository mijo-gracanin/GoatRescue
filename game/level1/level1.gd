extends Node2D

enum {STATE_INTRO, STATE_GAME, STATE_OUTRO}
var state = STATE_INTRO

func _ready():
	set_process_input(true)

func _input(event):
	var intro = get_node("intro")
	if intro.is_playing() and (event is InputEventKey or event is InputEventMouseButton):
		get_node("intro").set_speed_scale(8)

func _on_intro_finished(event):
	get_node("YSort/player").is_frozen = false

