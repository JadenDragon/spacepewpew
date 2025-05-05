extends Control


func _on_restart_button_pressed():
	pass # Replace with function body.
	get_tree().reload_current_scene()

func set_score(value):
	$Panel/Score.text = "Score: " + str(value)

func set_Highscore(value):
	$Panel/HighScore.text = "High Score: " + str(value)
	
