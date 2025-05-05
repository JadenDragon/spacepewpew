extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_game_pressed():
	pass # Replace with function body.
	visible = false
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_exit_pressed():
	pass # Replace with function body.
	print("exit pressed")
	get_tree().quit()


func _on_enemy_spawn_timer_timeout():
	pass # Replace with function body.
