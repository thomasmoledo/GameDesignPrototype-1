# spawner.gd
extends Node2D

@export var XO_scene: Array[PackedScene] = []
@export var speed := 400.0

var timer: Timer
var no_of_spawn_in_level = 0
var min_interval = 0.2
var max_interval = 1
var no_of_spawn_till_new_level = 10

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(spawn)
	add_child(timer)
	timer.start(randf_range(min_interval, max_interval))
	
func spawn() -> void:
	var xo : Node2D = XO_scene.pick_random().instantiate()
	xo.global_position = global_position
	xo.speed = speed
	get_parent().add_child(xo)
	no_of_spawn_in_level += 1
	if no_of_spawn_in_level > no_of_spawn_till_new_level:
		speed += 100
		no_of_spawn_in_level = 0
		if min_interval > 0.1:
			min_interval -= 0.1
		elif min_interval > 0.05:
			min_interval -= 0.01;
		if max_interval > 0.1:
			max_interval -= 0.1
		elif max_interval > 0.01:
			max_interval -= 0.01;
		timer.start(5)
	else:
		timer.start(randf_range(min_interval, max_interval))
