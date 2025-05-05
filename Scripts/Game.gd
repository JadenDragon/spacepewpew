extends Node2D

#array for list of enemies
@export var enemy_scenes: Array[PackedScene] = []

#ref for other scenes in Game scene
@onready var playerSpawnPoint = $PlayerSpawnMark
@onready var bulletContainer = $BulletContainer
@onready var enemyContainer = $EnemyContainer
@onready var timer = $EnemySpawnTimer
@onready var hud = $UILayer/HUD


var player = null
#set & update score on hud based on score value
var score := 0:
	set(value):
		score = value
		hud.score = score

# Called when the node enters the scene tree for the first time.
func _ready():
	hud.score = 0
	pass # Replace with function body.
	player = get_tree().get_first_node_in_group("player")
	#report when player not found
	assert(player != null)
	player.global_position = playerSpawnPoint.global_position
	
	#runs the _on_player_bullet_shot function
	player.bullet_shot.connect(_on_player_bullet_shot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#keys mainly used for testing
	#quits the game when action key is pressed
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	#restarts the game when action key is pressed
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_bullet_shot(bullet_scene, bulletPosition):
	#create bullet from bullet scene and adds it 
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bulletPosition
	#add bullet to container
	bulletContainer.add_child(bullet)

func _on_enemy_spawn_timer_timeout():
	#create new enemy instance from random
	var randE = enemy_scenes.pick_random().instantiate()
	randE.global_position = Vector2(randf_range(50,500), -50)
	randE.killed.connect(_on_enemy_killed)
	enemyContainer.add_child(randE)
	
	
func _on_enemy_killed(points):
	#gets points value from enemy when killed
	score += points
	print(score) 
