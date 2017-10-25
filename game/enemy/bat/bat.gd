extends Area2D

const DAMAGE = 0.5
const ATTACK_RATE = 0.7
const SPEED = 40

enum {MOVE, ATTACK}

var health = 10 setget set_health
var mode = MOVE
var path = []
onready var navigation = get_node("../../Navigation2D")
onready var player = get_node("../player")

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if mode == MOVE:
		move(delta)
	else:
		attack(delta)
	
func move(delta):
	if get_pos().distance_to(player.get_pos()) < 8:
		return
		
	if path.size() == 0 or path[-1].distance_to(player.get_pos()) > 60:
		path = navigation.get_simple_path(get_pos(), player.get_pos(), false)
		#print("PATH size: ", path.size())
	
	if path.size() > 1:
		var distance = get_pos().distance_to(path[0])
		if distance > 2:
			set_pos(get_pos().linear_interpolate(path[0], (SPEED * delta) / distance))
		else:
			path.remove(0)
	else:
		var velocity = (player.get_pos() - get_pos()).normalized() * SPEED * delta
		set_pos(get_pos() + velocity)
	
func attack(delta):
	pass
	
func set_health(value):
	if value <= 0:
		queue_free()
		# TODO: play some dying animation
	health = value

func _on_bat_body_enter(body):
	if body.get_name() == "player":
		mode = ATTACK

func _on_bat_body_exit(body):
	if body.get_name() == "player":
		mode = MOVE
