extends Node2D

#array for list of enemies
@export var enemy_scenes: Array[PackedScene] = []

#ref for other scenes in Game scene
@onready var playerSpawnPoint = $PlayerSpawnMark
@onready var bulletContainer = $BulletContainer
@onready var enemyContainer = $EnemyContainer
@onready var timer = $EnemySpawnTimer
@onready var hud = $UILayer/HUD
@onready var GameOverScreen = $UILayer/GameOverScreen
@onready var pBackground = $ParallaxBackground

@onready var bullet_sound = $SFX/Laser_SFX
@onready var damage_sound = $SFX/Damage_SFX
@onready var explode_sound = $SFX/Explode_SFX
@onready var restart_sound = $SFX/Restart_SFX

var player = null
#set & update score on hud based on score value
var score := 0:
	set(value):
		score = value
		hud.score = score
var high_score

var scroll_speed = 75

# Called when the node enters the scene tree for the first time.
func _ready():
	#opens the save file of user when game opens
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	
	hud.score = 0
	pass # Replace with function body.
	player = get_tree().get_first_node_in_group("player")
	#report when player not found
	assert(player != null)
	player.global_position = playerSpawnPoint.global_position
	#runs the _on_player_bullet_shot function
	player.bullet_shot.connect(_on_player_bullet_shot)
	player.player_died.connect(_on_player_died)

#creates a path to save data on user machine
func save_game():
	#create a save file from user play data.
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(high_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#keys mainly used for testing
	#quits the game when action key is pressed
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	#restarts the game when action key is pressed
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
	if timer.wait_time > 0.5:
		timer.wait_time -= delta * 0.005
	elif timer.wait_time < 0.5:
		timer.wait_time = 0.5
	#print(timer.wait_time)
	
	pBackground.scroll_offset.y += delta * scroll_speed
	if pBackground.scroll_offset.y >= 960:
		pBackground.scroll_offset.y = 0
	print(pBackground.scroll_offset.y)

func _on_player_bullet_shot(bullet_scene, bulletPosition):
	#create bullet from bullet scene and adds it 
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bulletPosition
	#add bullet to container
	bulletContainer.add_child(bullet)
	bullet_sound.play()

func _on_enemy_spawn_timer_timeout():
	#create new enemy instance from random
	var randE = enemy_scenes.pick_random().instantiate()
	randE.global_position = Vector2(randf_range(50,500), -50)
	#connect the damage sound to enemy when spawned
	randE.damage.connect(_on_enemy_damage)
	randE.killed.connect(_on_enemy_killed)
	enemyContainer.add_child(randE)
	
func _on_enemy_damage():
	damage_sound.play()
	
func _on_enemy_killed(points):
	damage_sound.play()
	#gets points value from enemy when killed
	score += points
	if score > high_score:
		high_score = score 
	#print(score) 

func _on_player_died():
	explode_sound.play()
	GameOverScreen.set_score(score)
	GameOverScreen.set_Highscore(high_score)
	save_game()
	await get_tree().create_timer(0.8).timeout
	GameOverScreen.visible = true

