class_name Player extends CharacterBody2D

signal bullet_shot(bullet_scene, bulletPosition)

@export var shipSpeed = 300
@export var shootSpeed = 0.3

@onready var barrel = $Barrel

#preloads the bullet scene as a variable
var bullet_scene = preload("res://Scenes/bullet.tscn")
#cooldown for bullet shooting
var  shoot_cd := false

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(_delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			#timer for shooting cooldown
			await get_tree().create_timer(shootSpeed).timeout
			shoot_cd = false

#physics process cause character is a physics body
func _physics_process(_delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), 
							Input.get_axis("move_up", "move_down"))
	print(direction)
	velocity = direction * shipSpeed	
	move_and_slide()

func shoot():
	#pass bullet scene and global position of barrel
	bullet_shot.emit(bullet_scene, barrel.global_position)

func die():
	queue_free()
