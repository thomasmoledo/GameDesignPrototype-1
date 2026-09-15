extends Area2D

@export var player_health = 100
@export var curr_symbol = null
@export var points = 0
@onready var texture_progress_bar: TextureProgressBar = $"../CanvasLayer/TextureProgressBar"
@onready var label: Label = $"../CanvasLayer/Label"

var end_scene = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture_progress_bar.value = player_health
	label.text = str(points)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		if end_scene == true:
			get_tree().reload_current_scene()
		if curr_symbol:
			if !curr_symbol.is_circle():
				lose_health(25)
				get_node("failed_audio").play()
			elif curr_symbol.is_circle():
				gain_health(2)
				points += 1
				get_node("success_audio").play()
			curr_symbol.queue_free()
			curr_symbol = null
			texture_progress_bar.value = player_health
			label.text = str(points)

func _on_area_entered(area: Area2D) -> void:
	curr_symbol = area

func _on_area_exited(area: Area2D) -> void:
	curr_symbol = null

func gain_health(health: int) -> void:
	if player_health + health > 100:
		player_health = 100
	else:
		player_health += health

func lose_health(health: int) -> void:
	if player_health - health < 0:
		player_health = 0
		end_game()
	else:
		player_health -= health

func end_game() -> void:
	get_node("game_over_audio").play()
	end_scene = true
	
