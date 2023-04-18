extends Control

onready var icon_temp: = $VBoxContainer/ScrollContainer/CenterContainer/HBoxContainer/IconTemp

var ships: Array
var ship_icons: Array
var selected_ship: Ship setget update_ui

func _ready():
	$AnimationPlayer.play("RESET")
	$VBoxContainer/ScrollContainer/CenterContainer/HBoxContainer/IconTemp.visible = false
	for ship_scene in Inventory.objectScenes["Ship"]:
		var ship: = Inventory.objectScenes["Ship"].get(ship_scene).instance() as Ship
		ships.append(ship)
	sort_ships()
	update_list()
	
	if not GameManager.selectedShip:
		self.selected_ship = ships.front()
	else:
		self.selected_ship = GameManager.selectedShip
	
	print(selected_ship.weaponSystem)
#	preload("res://Scenes/Equipments.tscn").instance()._ready()

func sort_ships():
	var locked: = []
	var unlocked: = []
	
	for ship in ships:
		ship = ship as Ship
		if ship.is_unlocked:
			unlocked.append(ship)
		else:
			locked.append(ship)
	
	ships.clear()
	ships.append_array(unlocked)
	ships.append_array(locked)

func update_ui(value):
	value = value as Ship
	selected_ship = value
	if selected_ship.is_unlocked:
		$VBoxContainer/ShipEquipButton.show()
		if selected_ship.name == GameManager.selectedShip.name:
			$VBoxContainer/ShipEquipButton.text = "Equipped"
			$VBoxContainer/ShipEquipButton.disabled = true
			
		else:
			$VBoxContainer/ShipEquipButton.text = "Equip"
			$VBoxContainer/ShipEquipButton.disabled = false
	else:
		$VBoxContainer/ShipEquipButton.hide()
	
	$VBoxContainer/HBoxContainer/ThumbnailPanel/TextureRect.texture = selected_ship.get_node("Sprite").texture
	var keys: = selected_ship.ShipRarity.keys()
	$VBoxContainer/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/Rarity/DurValue.text = str(keys[selected_ship.rarity])
#	$VBoxContainer/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/EquipmentCapacity/ECValue.text = str(selected_ship.max_equipment_capacity)
	$VBoxContainer/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/Durability/DurValue.text = str(selected_ship.max_durability)
	$VBoxContainer/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/UpgradeLevel/ULValue.text = str(selected_ship.max_upgrade_level)
	$VBoxContainer/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/ShipName.text = selected_ship.name
	$VBoxContainer/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/Special/SValue.text = "Special"
	$VBoxContainer/HBoxContainer/CenterContainer/Locked.visible = not selected_ship.is_unlocked

func update_list():
	for ship in ships:
		var icon: = icon_temp.duplicate() as TextureButton
		icon.visible = true
		icon.texture_normal = ship.get_node("Sprite").texture
		assert(icon.connect("button_up", self, "update_selected", [ship]) == OK)
		$VBoxContainer/ScrollContainer/CenterContainer/HBoxContainer.add_child(icon)
		ship_icons.append(icon)


func update_selected(value):
	print(value.name + " selected")
	self.selected_ship = value

func _on_BackButton_button_up():
	$AnimationPlayer.play("ToHome")

func to_home():
	assert(get_tree().change_scene("res://Scenes/MainMenu.tscn") == OK)

func _on_EquipmentsButton_button_up():
	$AnimationPlayer.play("ToEquipments")

func to_equipments():
	assert(get_tree().change_scene("res://Scenes/Equipments.tscn") == OK)


func _on_ShipEquipButton_button_up():
	GameManager.selectedShip = selected_ship
	
	update_ui(selected_ship)
#	if $VBoxContainer/ShipEquipButton.text == "Unequip":
#		GameManager.selectedShip = null
#	else:
#	if selected_ship == GameManager.selectedShip:
#		$VBoxContainer/ShipEquipButton.text = "Unequip"
#	else:
#		$VBoxContainer/ShipEquipButton.text = "Equip"
