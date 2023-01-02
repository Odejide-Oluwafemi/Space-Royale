extends Node

signal primary_weapon_changed(weapon)

var selectedEngineData: EngineResource #Inventory.resourceData["Engine"].front()
var selectedArmorData : ArmorResource  #Inventory.resourceData["Armor"].front()
var selectedShip      : Ship           #Inventory.objectScenes["Ship"].front()
var selectedPrimaryWeapon: PrimaryWeapon setget primaryWeaponSet# = Inventory.objectScenes["Weapon"].front().instance()
var selectedWeaponSystemData: WeaponSystemResource

func primaryWeaponSet(value):
	selectedPrimaryWeapon = value as PrimaryWeapon
	emit_signal("primary_weapon_changed", selectedPrimaryWeapon)
