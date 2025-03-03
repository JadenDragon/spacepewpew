extends Node2D
#ref for player spawn point
@onready var playerSpawnPoint = $PlayerSpawnMark

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	player = get_tree().get_first_node_in_group("player")
	#report when player not found
	assert(player != null)
	player.global_position = playerSpawnPoint.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#keys mainly used for testing
	#quits the game when action key is pressed
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	#restarts the game when action key is pressed
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
