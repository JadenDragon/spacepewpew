extends Area2D

@export var bulletSpeed = 800

func _physics_process(delta):
	#shoot the lasers in the Y axis
	global_position.y += -bulletSpeed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	#removes bullet objects after they exit the screen space
	queue_free()

func _on_area_entered(area):
	
	if area is Enemy:
		area.die()
		queue_free()
