extends Area2D

const DAMAGE = 0.5
const ATTACK_RATE = 0.7
const SPEED = 40

enum {MOVE, ATTACK}

var health = 20 setget set_health
var mode = MOVE
var path = []
onready var navigation = get_node("../../Navigation2D")
onready var player = get_node("../player")

func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	if mode == MOVE:
		move_and_collide(delta)
	else:
		attack(delta)
	
func move_and_collide(delta):
	if get_position().distance_to(player.get_position()) < 8:
		return
		
	if path.size() == 0 or path[-1].distance_to(player.get_position()) > 60:
		path = navigation.get_simple_path(get_position(), player.get_position(), false)
		#print("PATH size: ", path.size())
	
	if path.size() > 1:
		var distance = get_position().distance_to(path[0])
		if distance > 2:
			set_position(get_position().linear_interpolate(path[0], (SPEED * delta) / distance))
		else:
			path.remove(0)
	else:
		var velocity = (player.get_position() - get_position()).normalized() * SPEED * delta
		set_position(get_position() + velocity)
	
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

