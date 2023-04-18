extends Node2D

onready var spawn_timer: = $SpawnTimer

const MAX_ENEMY_ON_FIELD: = 8

var player: Ship
var players: Array
var number_of_ais: = 0
var score: = 0

func _ready():
	randomize()
	spawn_timer.wait_time = rand_range(0.3, 2)
	player = GameManager.selectedShip
	players.append(player as Ship)
	player.global_position = Vector2(randi() % ProjectSettings.get_setting("display/window/size/width"), randi() % ProjectSettings.get_setting("display/window/size/height"))
	
	add_child(player)
	player.safeZone = $SafeZoneArea
	(player.get_node("CamRemote") as RemoteTransform2D).remote_path = $PlayerCam.get_path()
	
	spawn_timer.stop()
	spawn_timer.start()
	$SafeZoneArea.monitoring = true

func _process(_delta):
	$CanvasLayer/UI.updateStats(player)

func spawn_ai():
	randomize()
	var ais = Inventory.ais
	ais.shuffle()
	var ai = ais.front().instance() as AI
	
	ai.position.x = player.position.x + rand_range(-1500, 1500)
	ai.position.y = player.position.y + rand_range(-1500, 1500)
	ai.safeZone = $SafeZoneArea
	add_child(ai)
	return ai


func _on_Timer_timeout():
	var ai = spawn_ai()
	assert(ai.connect("tree_exited", self, "ai_destroyed") == OK)
	number_of_ais += 1
	
	if number_of_ais >= MAX_ENEMY_ON_FIELD:
		spawn_timer.stop()
	else:
		spawn_timer.wait_time = rand_range(0.3, 2.0)
		spawn_timer.start()
	
func ai_destroyed():
	number_of_ais -= 1
	score += 1
	$CanvasLayer/UI/ShipStats/Kills/KillsValue.text = str(score)
	spawn_timer.start()

func _input(event):
	if event.is_action_released("pause"):
		pause()

func pause():
	get_tree().paused = true
	$CanvasLayer/PauseMenu.show()

func resumed_pause():
	get_tree().paused = false
	$CanvasLayer/PauseMenu.hide()
