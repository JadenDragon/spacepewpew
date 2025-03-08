extends Area2D

@export var bulletSpeed = 800

func _physics_process(delta):
	global_position.y += -bulletSpeed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.
	#removes bullet objects after they exit the screen space
	queue_free()
