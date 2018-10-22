extends KinematicBody2D

const SPEED = 80
const MOVING_BACKWARD_SPEED_PENALTY = 0.6
const ATTACK_TIME = 0.5
const INVINCIBILITY_TIME = 0.15
const projectile_scene = preload("res://projectile/projectile.tscn")

var health = 50 setget set_health
var attack_timer = 0
var invincibility_timer = 0
var is_facing_right = true
var is_frozen = true

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if is_frozen:
		return
		
	update_facing()
	process_input(delta)
	
func update_facing():
	var mouse_pos = get_local_mouse_position()

	if mouse_pos.x < 0:
		is_facing_right = !is_facing_right
		apply_scale(Vector2(-1, 1))

func get_relative_mouse_position():
	var mouse_pos = get_local_mouse_position()
	if !is_facing_right:
		mouse_pos.x = -mouse_pos.x
	return mouse_pos

func process_input(delta):
	process_movement(delta)
	process_attacks(delta)

func process_movement(delta):
	var movement_direction = Vector2(0, 0)
	
	if Input.is_action_pressed("move_up"):
		movement_direction += Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		movement_direction += Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		movement_direction += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		movement_direction += Vector2(1, 0)
		
	movement_direction = movement_direction.normalized() * delta * SPEED
	self.move_and_collide(movement_direction)
	
	if movement_direction.length() > 0 and !get_node("AnimationPlayer").is_playing():
		get_node("AnimationPlayer").play("Movement")
	elif movement_direction.length() == 0 and get_node("AnimationPlayer").is_playing():
		get_node("AnimationPlayer").stop()

func process_attacks(delta):
	if attack_timer > 0:
		attack_timer -= delta
		return
		
	if Input.is_action_pressed("lmb_action"):
		attack_timer = ATTACK_TIME
		var projectile = projectile_scene.instance()
		var cast_pos = get_position() + get_cast_offset()
		get_parent().add_child(projectile)
		projectile.set_position(cast_pos)
		projectile.direction = get_relative_mouse_position() - get_cast_offset()
		
func get_cast_offset():
	var x = 8 if is_facing_right else -8
	return Vector2(x, -10)
	

func set_health(value):
	if invincibility_timer > 0:
		return
		
	if value < health:
		invincibility_timer = INVINCIBILITY_TIME
		
	if value <= 0:
		queue_free()
		# TODO: play some dying animation
	health = value
		
