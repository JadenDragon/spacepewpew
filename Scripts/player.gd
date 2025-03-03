extends CharacterBody2D

@export var speed = 300

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#physics process cause character is a physics body
func _physics_process(delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), 
							Input.get_axis("move_up", "move_down"))
	print(direction)
	velocity = direction * speed
	move_and_slide()
