extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var speed = 20
var direction = Vector2.LEFT

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func is_circle() -> bool:
	if sprite_2d.texture.resource_path == "res://Sprites/Circle.png":
		return true
	return false
