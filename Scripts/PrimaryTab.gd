extends Tabs

onready var icon_temp: = $ScrollContainer/CenterContainer/HBoxContainer/IconTemp

var selected_primary: PrimaryWeapon setget update_primary_ui
var primaries: Array
var primary_icons: Array
var equipped_quantity: Dictionary
var max_capacity: int

func update_capacity_ui():
#	$HBoxContainer2/HBoxContainer/MaxCapacity.text = str(GameManager.selectedWeaponSystemData.primary_weapon_max_capacity)
#	$HBoxContainer2/HBoxContainer/UsedCapacity.text = str(GameManager.get_primary_capacity())
#	$HBoxContainer2/HBoxContainer/NewCapacity.text = "(~" + str(new_primary_capacity) + ")"
	$HBoxContainer2/HBoxContainer/WeaponCount/EquipCount.text = str(GameManager.equippedPrimaryWeapons.size())
	$HBoxContainer2/HBoxContainer/WeaponCount/MaxCount.text = str(max_capacity)
	

func _ready():
	setup()
	update_primary_list()
	
#	if not GameManager.selectedPrimaryWeapon:
#		self.selected_primary = primaries.front()
#	else:
#		self.selected_primary = GameManager.selectedPrimaryWeapon
	
	
	if not GameManager.equippedPrimaryWeapons.empty():
		for p_weapon in GameManager.equippedPrimaryWeapons:
			equipped_quantity[p_weapon.name] = GameManager.equippedPrimaryWeapons.count(p_weapon)
	
	
#	max_capacity = GameManager.selectedShip.weaponSystem.primary_weapon_max_capacity
	update_selected_primary(selected_primary)
	update_primary_ui(selected_primary)

func setup():
#	for res_item in Inventory.objectScenes["Weapon"]["Primary"]:
#		var item = Inventory.objectScenes["Weapon"]["Primary"].get(res_item).instance()
#		primaries.append(item)
#		equipped_quantity[item.name] = equipped_quantity[item.name] if equipped_quantity.has(item.name) else 0
	
	primaries = sort_item(primaries)
	selected_primary = primaries.front()
	
	if not GameManager.equippedPrimaryWeapons.empty():
		for weapon in GameManager.equippedPrimaryWeapons:
			weapon = weapon as PrimaryWeapon
			if not equipped_quantity.keys().has(weapon.weapon_name):
				equipped_quantity.keys().push_back(weapon.weapon_name)
			equipped_quantity[weapon.weapon_name] += 1

func sort_item(array: Array) -> Array:
	var locked: = []
	var unlocked: = []
	var sorted_array: = []
	
	for item in array:
		if item.is_unlocked:
			unlocked.append(item)
		else:
			locked.append(item)

	sorted_array.append_array(unlocked)
	sorted_array.append_array(locked)
	
	return sorted_array

func update_primary_list():
	for primary in primaries:
		primary = primary as PrimaryWeapon
		var icon: = icon_temp.duplicate() as TextureButton
		icon.visible = true
		icon.texture_normal = primary.thumbnail
		assert(icon.connect("button_up", self, "update_selected_primary", [primary]) == OK)
		$ScrollContainer/CenterContainer/HBoxContainer.add_child(icon)
		primary_icons.append(icon)

func update_selected_primary(primary):
	print(primary.name + " selected")
	self.selected_primary = primary
	
	$HBoxContainer2/PWeaponAddButton.visible = primary.is_unlocked
	$HBoxContainer2/PWeaponRemoveButton.visible = primary.is_unlocked

	$HBoxContainer2/PWeaponAddButton.disabled = GameManager.equippedPrimaryWeapons.size() >= max_capacity
	$HBoxContainer2/PWeaponRemoveButton.disabled = not GameManager.equippedPrimaryWeapons.has(selected_primary)#equipped_quantity[selected_primary.name] <= 0#
	
#	if not GameManager.selectedShip.weaponSystem.primary_weapon_max_capacity - GameManager.get_primary_capacity() >= selected_primary.size:
#		$PWeaponAddButton.disabled = true
#	else:
#		$PWeaponAddButton.disabled = false
#
#	if equipped_quantity[selected_primary.name] <= 0:
#		$PWeaponRemoveButton.disabled = true
#	else:
#		$PWeaponRemoveButton.disabled = false
#
#	self.new_primary_capacity = GameManager.get_primary_capacity() + selected_primary.size

func update_primary_ui(value):
	value = value as PrimaryWeapon
#	if not value:
#		return
	selected_primary = value
	if selected_primary.is_unlocked:
		$HBoxContainer2/PWeaponAddButton.show()
		$HBoxContainer2/PWeaponRemoveButton.show()
		$HBoxContainer2/HBoxContainer/WeaponCount.show()
#		$HBoxContainer2/QuantityLabel.text = "(" + str(equipped_quantity[selected_primary.name]) + ")"
#		if selected_primary == GameManager.selectedPrimaryWeapon:
#			$PWeaponEquipButton.text = "Unequip"
#		else:
#			$PWeaponEquipButton.text = "Equip"
	else:
		$HBoxContainer2/PWeaponAddButton.hide()
		$HBoxContainer2/PWeaponRemoveButton.hide()
		$HBoxContainer2/HBoxContainer/WeaponCount.hide()
#		$PWeaponAddButton.hide()
#		$PWeaponRemoveButton.hide()
#		$HBoxContainer2/QuantityLabel.hide()
	
#	self.new_primary_capacity = GameManager.get_primary_capacity() + selected_primary.size
	$HBoxContainer/ThumbnailPanel/TextureRect.texture = selected_primary.thumbnail
	$HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/PWName.text = selected_primary.weapon_name
	$HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/MaxAmmoHoldable/MAHValue.text = str(selected_primary.max_ammo_holdable)
	$HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/MagSize/MSValue.text = str(selected_primary.magazine_size)
	$HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/ReloadSpeed/RSValue.text = str(selected_primary.reloadSpeed) + 's'
	$HBoxContainer/CenterContainer/Locked.visible = not selected_primary.is_unlocked
#	$HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/Weight/WValue.text = str(selected_primary.size)
	$HBoxContainer/StatsPanel/VBoxContainer/VBoxContainer/FiringRate/FRValue.text = str(selected_primary.firingRate) + 's'


#	if $PWeaponEquipButton.text == "Unequip":
#		GameManager.selectedPrimaryWeapon = null
#		GameManager.equippedPrimaryWeapons.remove(GameManager.equippedPrimaryWeapons.find_last(selected_primary))
#	else:
#		GameManager.selectedPrimaryWeapon = selected_primary
#		# Do [Weapon Systems' Primary Weapon Capacity] Check Here Before Appending!!!
#		GameManager.equippedPrimaryWeapons.append(selected_primary)
#	if selected_primary == GameManager.selectedPrimaryWeapon:
#		$PWeaponEquipButton.text = "Unequip"
#	else:
#		$PWeaponEquipButton.text = "Equip"



func _on_PWeaponAddButton_button_up():
#	selected_primary = selected_primary
	GameManager.equippedPrimaryWeapons.append(selected_primary.duplicate())
	equipped_quantity[selected_primary.name] += 1
	update_selected_primary(selected_primary)
	update_primary_ui(selected_primary)

func _on_PWeaponRemoveButton_button_up():
	if GameManager.equippedPrimaryWeapons.find(selected_primary) < 0:
		return
	GameManager.equippedPrimaryWeapons.remove(GameManager.equippedPrimaryWeapons.find(selected_primary))
	self.equipped_quantity[selected_primary.name] -= 1
	update_selected_primary(selected_primary)
#	update_primary_ui(selected_primary)
