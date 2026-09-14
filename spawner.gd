# spawner.gd
extends Node2D

@export var XO_scene: Array[PackedScene] = []
@export var speed := 400.0

var timer: Timer
var increment_speed = 0

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(spawn)
	add_child(timer)
	timer.start(randf_range(0.5, 2))

func spawn() -> void:
	var xo : Node2D = XO_scene.pick_random().instantiate()
	xo.global_position = global_position
	xo.speed = speed
	get_parent().add_child(xo)
	timer.start(randf_range(0.5, 2))
	increment_speed += 1
	if increment_speed > 10:
		speed += 200
		increment_speed = 0
