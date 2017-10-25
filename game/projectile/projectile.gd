extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var direction = Vector2(1, 0)
var immune
const SPEED = 200
const DAMAGE = 10

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if direction.length() == 0:
		return
		
	var position = get_pos()
	position += direction.normalized() * SPEED * delta
	set_pos(position)

func _on_projectile_body_enter(body):
	if body extends TileMap:
		queue_free()
	else:
		pass

func _on_projectile_area_enter( area ):
	if area.get_name() == "bat":
		area.health -= DAMAGE
