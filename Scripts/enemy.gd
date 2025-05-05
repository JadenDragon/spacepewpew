class_name Enemy extends Area2D

signal killed(points)

@export var speed = 150
@export var hitpoints = 1
@export var points = 100

func _physics_process(delta):
	global_position.y += speed * delta

func die():
	queue_free()


func _on_body_entered(body):
	pass # Replace with function body.
	if body is Player:
		body.die()
		die()

func take_damage(amount):
	hitpoints -= amount
	if hitpoints <= 0:
		#sends points of enemies on killed to game script
		killed.emit(points)
		die()
