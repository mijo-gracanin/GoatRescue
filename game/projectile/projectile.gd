extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var direction = Vector2(1, 0)
var immune
const SPEED = 200
const DAMAGE = 10

func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	if direction.length() == 0:
		return
		
	var position = get_position()
	position += direction.normalized() * SPEED * delta
	set_position(position)

func _on_projectile_body_enter(body):
	if body is TileMap:
		queue_free()
	else:
		pass

func _on_projectile_area_enter( area ):
	if area.get_name() == "bat":
		area.health -= DAMAGE

