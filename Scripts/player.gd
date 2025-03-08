extends CharacterBody2D

signal bullet_shot(bullet_scene, bulletPosition)

@export var shipSpeed = 300

@onready var barrel = $Barrel

var bullet_scene = preload("res://Scenes/bullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

#physics process cause character is a physics body
func _physics_process(delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), 
							Input.get_axis("move_up", "move_down"))
	print(direction)
	velocity = direction * shipSpeed	
	move_and_slide()

func shoot():
	#pass bullet scene and global position of barrel
	bullet_shot.emit(bullet_scene, barrel.global_position)
