extends Control

signal restart

func _on_restart_button_pressed():
	pass # Replace with function body.
	get_tree().reload_current_scene()
	restart.emit()

func set_score(value):
	$Panel/Score.text = "Score: " + str(value)

func set_Highscore(value):
	$Panel/HighScore.text = "High Score: " + str(value)
	

func _on_exit_pressed():
	get_tree().quit()
