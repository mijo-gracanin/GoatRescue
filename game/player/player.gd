extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
		set_fixed_process(true)

func _fixed_process(delta):
	process_input(delta)
	
func process_input(delta):
	var movement_direction = Vector2(0, 0)
	
	if Input.is_action_pressed("move_up"):
		movement_direction += Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		movement_direction += Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		movement_direction += Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		movement_direction += Vector2(1, 0)
		
	movement_direction = movement_direction.normalized() * delta * 80
	self.move(movement_direction)
	
	if movement_direction.length() > 0 and !get_node("AnimationPlayer").is_playing():
		get_node("AnimationPlayer").play("Movement")
	elif movement_direction.length() == 0 and get_node("AnimationPlayer").is_playing():
		get_node("AnimationPlayer").stop()