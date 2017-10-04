extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_normalButton_pressed():
	get_tree().change_scene("res://level1/level1.tscn")

func _on_hardcoreButton_pressed():
	pass # replace with function body

func _on_creditsButton_pressed():
	pass # replace with function body
