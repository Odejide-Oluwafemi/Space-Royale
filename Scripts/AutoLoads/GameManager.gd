extends Node

var DEFAULT_SHIP: = Inventory.objectScenes["Ship"]["BlueDevil"].instance() as Ship
var DEFAULT_PWEAPON = Inventory.objectScenes["Weapon"]["Primary"]["GatlingGun"]
#var DEFAULT_ENGINE: = Inventory.resourceData["Engine"]["BasicEngine"] as EngineResource
#var DEFAULT_ARMOR: = Inventory.resourceData["Armor"]["BasicArmor"] as ArmorResource
#var DEFAULT_WEAPON_SYSTEM: = Inventory.resourceData["WeaponSystem"]["BasicWeaponSystem"] as WeaponSystemResource

#var selectedEngineData: EngineResource = DEFAULT_ENGINE   #Inventory.resourceData["Engine"]["BasicEngine"]
#var selectedArmorData : ArmorResource = DEFAULT_ARMOR    #Inventory.resourceData["Armor"]["BasicArmor"]
var selectedShip      : Ship = DEFAULT_SHIP             #Inventory.objectScenes["Ship"].front()
#var selectedWeaponSystemData: WeaponSystemResource = DEFAULT_WEAPON_SYSTEM

#var equippedPrimaryWeapons: = [Inventory.objectScenes["Weapon"]["Primary"]["GatlingGun"].instance(), Inventory.objectScenes["Weapon"]["Primary"]["GatlingGun"].instance(), Inventory.objectScenes["Weapon"]["Primary"]["GatlingGun"].instance()]
#var selectedPrimaryWeapon: PrimaryWeapon# = equippedPrimaryWeapons.front() # = Inventory.objectScenes["Weapon"].front().instance()

#func get_capacity() -> int:
#	var total: = 0
#	for item in [selectedArmorData, selectedEngineData, selectedWeaponSystemData]:
#		item = item as Item
#		if not item:
#			continue
#		total += item.weight
#	return total

#func get_primary_capacity() -> int:
#	var total: = 0
#
#	for primary in equippedPrimaryWeapons:
#		primary = primary as PrimaryWeapon
#		if not primary:
#			continue
#		total += primary.size
#
#	return total
