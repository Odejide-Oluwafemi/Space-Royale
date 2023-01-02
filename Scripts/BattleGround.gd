extends Node2D

var player: Ship
var players: Array

func _ready():
	randomize()
	GameManager.selectedShip = Inventory.objectScenes["Ship"].front().instance() as Ship
	GameManager.selectedArmorData = Inventory.resourceData["Armor"].front() as ArmorResource
	GameManager.selectedEngineData = Inventory.resourceData["Engine"].front() as EngineResource
	GameManager.selectedWeaponSystemData = Inventory.resourceData["WeaponSystem"].front() as WeaponSystemResource
	
	player = GameManager.selectedShip
	players.append(player as Ship)
	player.global_position = Vector2(randi() % ProjectSettings.get_setting("display/window/size/width"), randi() % ProjectSettings.get_setting("display/window/size/height"))
	add_child(player)
	player.weaponSystem.addWeapon(Inventory.objectScenes["Weapon"]["Primary"].front().instance() as PrimaryWeapon)
	player.weaponSystem.addWeapon(Inventory.objectScenes["Weapon"]["Primary"].front().instance() as PrimaryWeapon)

	$SafeZoneArea.monitoring = true

func _process(_delta):
	$CanvasLayer/UI.updateStats(player)

