extends Node2D

class_name WeaponSystem

signal primary_weapon_changed

export(float) var primary_weapon_switch_duration

onready var pWeaponSwitchTimer: = $PrimarySwitchTimer
var primaryWeapon: PrimaryWeapon

var ship: Ship setget ship_set

func ship_set(value: Ship):
	ship = value
	primaryWeapon = GameManager.DEFAULT_PWEAPON.instance() as PrimaryWeapon
	primaryWeapon.isActive = true
	primaryWeapon.ship = ship
	add_child(primaryWeapon)

func _ready():
	pWeaponSwitchTimer.wait_time = primary_weapon_switch_duration
	
#	if get_child_count() > 0:
#		(get_children().front() as Weapon).isActive = true

func replaceWeapon(new_weapon: Weapon):
	if new_weapon is PrimaryWeapon:
		primaryWeapon = new_weapon
		emit_signal("primary_weapon_changed", [primaryWeapon])

#var primaryWeapons: = [] setget weaponAdded
#var selectedPrimaryWeapon: PrimaryWeapon setget set_primary_weapon
#var thumbnail: Texture
#
#func set_primary_weapon(value):
#	selectedPrimaryWeapon = value
#	GameManager.selectedPrimaryWeapon = selectedPrimaryWeapon
#	emit_signal("primary_weapon_changed", selectedPrimaryWeapon)
#
#func weaponAdded(value):
##	var totalCapacity: = 0.0
#	primaryWeapons.append(value)
##	for primaryWeapon in primaryWeapons:
##		totalCapacity += primaryWeapon.size
#	#primaryWeaponCapacity += 1#totalCapacity
#	selectedPrimaryWeapon = value
#
#func addWeapon(weapon: Weapon):
#	if primaryWeapons.size() >= primary_weapon_max_capacity:
#		print("Cannot Eqiup any more Weapons!")
#		return
#	weapon.isActive = true
#	weapon.ship = ship
#	weapon.name += str(primaryWeapons.size())
#	if weapon is PrimaryWeapon:
##		if primaryWeaponCapacity < weapon.size:
##			print("Not Enough Primary Weapon Space")
##			return
#		primaryWeapons.append(weapon)
#		assert(weapon.connect("ammo_depleted", self, "changePrimaryWeapon") == OK)
#		add_child(weapon)
#		primaryWeaponCapacity -= 1 #weapon.size
#		self.selectedPrimaryWeapon = weapon
#
#
#func discardWeapon(weapon: Weapon):
#	if not weapon in get_children():
#		print("%s was never Mounted!" % weapon.name)
#		return
#
#	if weapon is PrimaryWeapon:
#		primaryWeapons.remove(primaryWeapons.find(selectedPrimaryWeapon))
#
#		if weapon == selectedPrimaryWeapon:
#			changePrimaryWeapon()
#
#	for equippedWeapon in get_children():
#		if equippedWeapon == weapon:
#			equippedWeapon.queue_free()
#
#func replaceWeapon(newWeapon: Weapon):
#	if newWeapon is PrimaryWeapon:
#		print ("Replaced %s" % (selectedPrimaryWeapon as PrimaryWeapon))
#		var currentPrimaryWeapon: = selectedPrimaryWeapon as PrimaryWeapon
#		var tempAvailableCapacity = primaryWeaponCapacity + currentPrimaryWeapon.size
#		if tempAvailableCapacity >= newWeapon.size:
#			primaryWeapons[primaryWeapons.find(currentPrimaryWeapon)] = newWeapon
#			print("With %s" % newWeapon as PrimaryWeapon)
#			for weapon in get_children():
#				if weapon == currentPrimaryWeapon:
#					weapon.queue_free()
#			add_child(newWeapon)
#			newWeapon.isActive = true
#			selectedPrimaryWeapon = newWeapon
#
#		else:
#			print("Not Enough Primary Weapon Space")
#
#func changePrimaryWeapon(weapon: PrimaryWeapon = null):
#	var alternateWeapon: PrimaryWeapon = null
#
#	if weapon and weapon in primaryWeapons:
#		alternateWeapon = weapon
#	else:
#		for wpn in primaryWeapons:
#			wpn = wpn as PrimaryWeapon
#			if wpn.hasAmmo():
#				alternateWeapon = wpn
#				break
#
#
##	var weaponIndex: = primaryWeapons.find(selectedPrimaryWeapon)
##
##	if not (weaponIndex - 1) < 0 :
##		alternateWeapon = primaryWeapons[weaponIndex - 1]
##	elif not (weaponIndex + 1) >= primaryWeapons.size():
##		alternateWeapon = primaryWeapons[weaponIndex + 1]
##	else:
##		alternateWeapon = null
#
#	if not alternateWeapon:
##		self.selectedPrimaryWeapon = null
#		return
#
##	if not alternateWeapon.hasAmmo():#ammoAtHand <= 0 and alternateWeapon.ammoInGun <= 0:
##		return
#
#	print("Switching Weapon...")
##	yield(get_tree().create_timer(primary_weapon_switch_duration), "timeout")
#	pWeaponSwitchTimer.start()
#	yield(pWeaponSwitchTimer,"timeout")
#
#	self.selectedPrimaryWeapon = alternateWeapon
#	print ("Switched Weapon to: %s" % alternateWeapon.name)
