extends Control

#enum tabs{
#	ENGINE,
#	ARMOR,
#	WEAPONSYSTEM,
#	PRIMARY
#}

onready var icon_temp: = $VBoxContainer/TabContainer/Primary/ScrollContainer/CenterContainer/HBoxContainer/IconTemp#$VBoxContainer/TabContainer/Engine/ScrollContainer/CenterContainer/HBoxContainer/IconTemp
#onready var primary_tab: = preload("res://Scenes/PrimaryTab.tscn").instance()

#var selected_engine: EngineResource setget update_engine_ui
#var selected_armor:  ArmorResource setget update_armor_ui
#var selected_weapon_system: WeaponSystemResource setget update_weapon_system_ui

#var engines: Array
#var armors: Array
#var weapon_systems: Array

#var engine_icons: Array
#var armor_icons: Array
#var weapon_system_icons: Array

#var new_equipment_capacity: int setget update_new_capacity

#func update_new_capacity(value):
#	new_equipment_capacity = value
#	update_capacity_ui()

func _ready():
	$AnimationPlayer.play("RESET")
#	setup("Engine")
#	setup("Armor")
#	setup("WeaponSystem")
	
#	update_engine_list()
#	update_armor_list()
#	update_weapon_systems_list()
	
#	if not GameManager.selectedArmorData:
#		self.selected_armor = armors.front().data
#	else:
#		self.selected_armor = GameManager.selectedArmorData
#	update_weapon_system_ui(selected_armor)
#
#	if not GameManager.selectedEngineData:
#		self.selected_engine = engines.front().data
#	else:
#		self.selected_engine = GameManager.selectedEngineData
#	update_selected_engine(selected_engine)
#	_on_EngineEquipButton_button_up()
#	update_weapon_system_ui(selected_engine)
#
#	if not GameManager.selectedWeaponSystemData:
#		self.selected_weapon_system = weapon_systems.front().data
#	else:
#		self.selected_weapon_system = GameManager.selectedWeaponSystemData
#	update_weapon_system_ui(selected_weapon_system)

#	if GameManager.selectedWeaponSystemData:
#		$VBoxContainer/TabContainer.add_child(primary_tab)
#	else:
#		$VBoxContainer/TabContainer.remove_child(primary_tab)

#func update_capacity_ui():
#	$VBoxContainer/HBoxContainer2/ShipEquipmentCapacity/TotalCapacity.text = str(GameManager.selectedShip.max_equipment_capacity)
#	$VBoxContainer/HBoxContainer2/ShipEquipmentCapacity/UsedCapacity.text = str(GameManager.get_capacity())
#	$VBoxContainer/HBoxContainer2/ShipEquipmentCapacity/NewCapacity.text = "(~" + str(new_equipment_capacity) + ")"

#func setup(val: String):
#	for res_item in Inventory.resourceData[val]:
#		var item = Inventory.resourceData[val].get(res_item)
#		var node = Inventory.abstractScenes[val].instance()
#		if val == "Engine":
#			node.data = item as EngineResource
#			engines.append(node)
#		elif val == "Armor":
#			node.data = item as ArmorResource
#			armors.append(node)
#		elif val == "WeaponSystem":
#			node.data = item as WeaponSystemResource
#			weapon_systems.append(node)
#	engines = sort_item(engines)
#	armors = sort_item(armors)
#	weapon_systems = sort_item(weapon_systems)


func sort_item(array: Array) -> Array:
	var locked: = []
	var unlocked: = []
	var sorted_array: = []
	
	for item in array:
		if item.data.IsUnlocked:
			unlocked.append(item)
		else:
			locked.append(item)

	sorted_array.append_array(unlocked)
	sorted_array.append_array(locked)
	
	return sorted_array

#func update_engine_list():
#	for engine in engines:
#		var icon: = icon_temp.duplicate() as TextureButton
#		icon.visible = true
#		icon.texture_normal = engine.thumbnail
#		assert(icon.connect("button_up", self, "update_selected_engine", [engine.data]) == OK)
#		$VBoxContainer/TabContainer/Engine/ScrollContainer/CenterContainer/HBoxContainer.add_child(icon)
#		engine_icons.append(icon)
#
#func update_armor_list():
#	for armor in armors:
#		armor = armor as Armor
#		var icon: = icon_temp.duplicate() as TextureButton
#		icon.visible = true
#		icon.texture_normal = armor.thumbnail
#		assert(icon.connect("button_up", self, "update_selected_armor", [armor.data]) == OK)
#		$VBoxContainer/TabContainer/Armor/ScrollContainer/CenterContainer/HBoxContainer.add_child(icon)
#		armor_icons.append(icon)
#
#func update_weapon_systems_list():
#	for weapon_system in weapon_systems:
#		weapon_system = weapon_system as WeaponSystem
#		var icon: = icon_temp.duplicate() as TextureButton
#		icon.visible = true
#		icon.texture_normal = weapon_system.thumbnail
#		assert(icon.connect("button_up", self, "update_selected_weapon_system", [weapon_system.data]) == OK)
#		$VBoxContainer/TabContainer/WeaponSystem/ScrollContainer/CenterContainer/HBoxContainer.add_child(icon)
#		weapon_system_icons.append(icon)

#func update_selected_engine(engine: EngineResource):
#	print(engine.Name + " selected")
#	self.selected_engine = engine
#
#	self.new_equipment_capacity = GameManager.get_capacity() + selected_engine.weight if not GameManager.selectedEngineData == selected_engine else GameManager.get_capacity() - selected_engine.weight
#	update_capacity_ui()

#func update_selected_armor(armor: ArmorResource):
#	print(armor.Name + " selected")
#	self.selected_armor = armor
#
#	self.new_equipment_capacity = GameManager.get_capacity() + selected_armor.weight if not GameManager.selectedArmorData == selected_armor else GameManager.get_capacity() - selected_armor.weight
#	update_capacity_ui()
	
#func update_selected_weapon_system(weapon_system: WeaponSystemResource):
#	print(weapon_system.Name + " selected")
#	self.selected_weapon_system = weapon_system
#
#	self.new_equipment_capacity = GameManager.get_capacity() + selected_weapon_system.weight if not GameManager.selectedWeaponSystemData == selected_weapon_system else GameManager.get_capacity() - selected_weapon_system.weight
#	update_capacity_ui()

#func update_engine_ui(value):
#	value = value as EngineResource
#	if not value:
#		return
#	selected_engine = value
#	if selected_engine.IsUnlocked:
#		$VBoxContainer/TabContainer/Engine/EngineEquipButton.show()
#		if selected_engine == GameManager.selectedEngineData:
#			$VBoxContainer/TabContainer/Engine/EngineEquipButton.text = "Equipped"
#			$VBoxContainer/TabContainer/Engine/EngineEquipButton.disabled = true
#		else:
#			$VBoxContainer/TabContainer/Engine/EngineEquipButton.text = "Equip"
#			$VBoxContainer/TabContainer/Engine/EngineEquipButton.disabled = false
##	else:
##		$VBoxContainer/TabContainer/Engine/EngineEquipButton.hide()
#	update_capacity_ui()
#	$VBoxContainer/TabContainer/Engine/HBoxContainer/ThumbnailPanel/TextureRect.texture = selected_engine.Thumbnail
#	$VBoxContainer/TabContainer/Engine/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/EngineName.text = selected_engine.Name
#	$VBoxContainer/TabContainer/Engine/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/Speed/SValue.text = str(selected_engine.max_speed)
#	$VBoxContainer/TabContainer/Engine/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/Weight/WValue.text = str(selected_engine.weight)
#	$VBoxContainer/TabContainer/Engine/HBoxContainer/CenterContainer/Locked.visible = not selected_engine.IsUnlocked
#	$VBoxContainer/TabContainer/Engine/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/Weight/WValue.text = str(selected_engine.weight)

#func update_armor_ui(value):
#	value = value as ArmorResource
#	if not value:
#		return
#	selected_armor = value
#	if selected_armor.IsUnlocked:
#		$VBoxContainer/TabContainer/Armor/ArmorEquipButton.show()
#		if selected_armor == GameManager.selectedArmorData:
#			$VBoxContainer/TabContainer/Armor/ArmorEquipButton.text = "Unequip"
#		else:
#			$VBoxContainer/TabContainer/Armor/ArmorEquipButton.text = "Equip"
#	else:
#		$VBoxContainer/TabContainer/Armor/ArmorEquipButton.hide()
#	update_capacity_ui()
#	$VBoxContainer/TabContainer/Armor/HBoxContainer/ThumbnailPanel/TextureRect.texture = selected_armor.Thumbnail
#	$VBoxContainer/TabContainer/Armor/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/ArmorName.text = selected_armor.Name
#	$VBoxContainer/TabContainer/Armor/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/MaxArmor/MAValue.text = str(selected_armor.max_armor)
#	$VBoxContainer/TabContainer/Armor/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/RegenSpeed/RSValue.text = str(selected_armor.regenerate_speed) + 's'
#	$VBoxContainer/TabContainer/Armor/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/RegenValue/RValue.text = str(selected_armor.regen_value)
#	$VBoxContainer/TabContainer/Armor/HBoxContainer/CenterContainer/Locked.visible = not selected_armor.IsUnlocked
#	$VBoxContainer/TabContainer/Armor/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/Weight/WValue.text = str(selected_armor.weight)

#func update_weapon_system_ui(value):
#	value = value as WeaponSystemResource
#	if not value:
#		return
#	selected_weapon_system = value
#	if selected_weapon_system.IsUnlocked:
#		$VBoxContainer/TabContainer/WeaponSystem/WSystemEquipButton.show()
#		if selected_weapon_system == GameManager.selectedWeaponSystemData:
#			$VBoxContainer/TabContainer/WeaponSystem/WSystemEquipButton.text = "Unequip"
#		else:
#			$VBoxContainer/TabContainer/WeaponSystem/WSystemEquipButton.text = "Equip"
#	else:
#		$VBoxContainer/TabContainer/WeaponSystem/WSystemEquipButton.hide()
#	update_capacity_ui()
#	$VBoxContainer/TabContainer/WeaponSystem/HBoxContainer/ThumbnailPanel/TextureRect.texture = selected_weapon_system.Thumbnail
#	$VBoxContainer/TabContainer/WeaponSystem/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/WSName.text = selected_weapon_system.Name
#	$VBoxContainer/TabContainer/WeaponSystem/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/PWMaxCap/PWMCValue.text = str(selected_weapon_system.primary_weapon_max_capacity)
#	$VBoxContainer/TabContainer/WeaponSystem/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/PWSwitchDur/PWSDValue.text = str(selected_weapon_system.PrimaryWeaponSwitchDuration) + 's'
#	$VBoxContainer/TabContainer/WeaponSystem/HBoxContainer/CenterContainer/Locked.visible = not selected_weapon_system.IsUnlocked
#	$VBoxContainer/TabContainer/WeaponSystem/HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/Weight/WValue.text = str(selected_weapon_system.weight)

func _on_BackButton_button_up():
	$AnimationPlayer.play("ToHangar")

func to_hangar():
	assert(get_tree().change_scene("res://Scenes/Hangar.tscn") == OK)

#func _on_EngineEquipButton_button_up():
#	GameManager.selectedEngineData = selected_engine
#	update_engine_ui(selected_engine)
#	self.new_equipment_capacity = GameManager.get_capacity() + selected_engine.weight if not GameManager.selectedEngineData == selected_engine else GameManager.get_capacity() - selected_engine.weight
#	update_capacity_ui()
#	if $VBoxContainer/TabContainer/Engine/EngineEquipButton.text == "Unequip":
#		GameManager.selectedEngineData = null
#		pass
#	else:
#		GameManager.selectedEngineData = selected_engine
#	if selected_engine == GameManager.selectedEngineData:
#			$VBoxContainer/TabContainer/Engine/EngineEquipButton.text = "Unequip"
#	else:
#			$VBoxContainer/TabContainer/Engine/EngineEquipButton.text = "Equip"

#
#func _on_ArmorEquipButton_button_up():
#	if $VBoxContainer/TabContainer/Armor/ArmorEquipButton.text == "Unequip":
#		GameManager.selectedArmorData = null
#	else:
#		GameManager.selectedArmorData = selected_armor
#	if selected_armor == GameManager.selectedArmorData:
#		$VBoxContainer/TabContainer/Armor/ArmorEquipButton.text = "Unequip"
#	else:
#		$VBoxContainer/TabContainer/Armor/ArmorEquipButton.text = "Equip"
#	update_engine_ui(selected_armor)
#	self.new_equipment_capacity = GameManager.get_capacity() + selected_armor.weight if not GameManager.selectedArmorData == selected_armor else GameManager.get_capacity() - selected_armor.weight
#	update_capacity_ui()

#func _on_WSystemEquipButton_button_up():
#	if $VBoxContainer/TabContainer/WeaponSystem/WSystemEquipButton.text == "Unequip":
#		GameManager.selectedWeaponSystemData = null
#	else:
#		GameManager.selectedWeaponSystemData = selected_weapon_system
#	if selected_weapon_system == GameManager.selectedWeaponSystemData:
#		$VBoxContainer/TabContainer/WeaponSystem/WSystemEquipButton.text = "Unequip"
#	else:
#		$VBoxContainer/TabContainer/WeaponSystem/WSystemEquipButton.text = "Equip"
#
#	if GameManager.selectedWeaponSystemData:
#		$VBoxContainer/TabContainer.add_child(primary_tab)
#	else:
#		$VBoxContainer/TabContainer.remove_child(primary_tab)
#		GameManager.selectedPrimaryWeapon = null
#	update_engine_ui(selected_weapon_system)
#	self.new_equipment_capacity = GameManager.get_capacity() + selected_weapon_system.weight if not GameManager.selectedWeaponSystemData == selected_weapon_system else GameManager.get_capacity() - selected_weapon_system.weight
#	update_capacity_ui()


#func _on_TabContainer_tab_changed(tab):
#	var new_capacity: int = 0
#	if tab == tabs.ENGINE:
#		new_capacity = GameManager.get_capacity() + selected_engine.weight if not GameManager.selectedEngineData == selected_engine else GameManager.get_capacity() - selected_engine.weight
#	elif tab == tabs.ARMOR:
#		new_capacity = GameManager.get_capacity() + selected_armor.weight if not GameManager.selectedArmorData == selected_armor else GameManager.get_capacity() - selected_armor.weight
#	elif tab == tabs.WEAPONSYSTEM:
#		new_capacity = GameManager.get_capacity() + selected_weapon_system.weight if not GameManager.selectedWeaponSystemData == selected_weapon_system else GameManager.get_capacity() - selected_weapon_system.weight
#
#	self.new_equipment_capacity = new_capacity
