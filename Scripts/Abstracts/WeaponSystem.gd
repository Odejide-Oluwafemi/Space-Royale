extends Node2D

class_name WeaponSystem

export(Resource) var data

onready var ship : = GameManager.selectedShip as Ship

var primaryWeapons: = [] setget weaponAdded
var primaryWeaponCapacity

func weaponAdded(value):
	var totalCapacity: = 0.0
	primaryWeapons.append(value)
	for primaryWeapon in primaryWeapons:
		totalCapacity += primaryWeapon.size
	primaryWeaponCapacity = totalCapacity

func _ready():
#	assert (primaryWeaponScene or GameManager.selectedPrimaryWeapon, "Primary Weapon Needs to be set")
#	assert (shipNode or GameManager.selectedShip, "Ship Needs to be set")
	#ship = get_node(shipNode) as Ship if shipNode else GameManager.selectedShip
	data = GameManager.selectedWeaponSystemData
	primaryWeaponCapacity = data.primary_weapon_max_capacity

func addWeapon(weapon: Weapon):
	weapon.isActive = true
	weapon.ship = ship
	weapon.name += str(primaryWeapons.size())
	if weapon is PrimaryWeapon:
		if primaryWeaponCapacity < weapon.size:
			print("Not Enough Primary Weapon Space")
			return
		primaryWeapons.append(weapon)
		assert(weapon.connect("ammo_depleted", self, "changePrimaryWeapon") == OK)
		GameManager.selectedPrimaryWeapon = weapon
		add_child(weapon)
		primaryWeaponCapacity -= weapon.size
	

func discardWeapon(weapon: Weapon):
	if weapon in primaryWeapons:
		if weapon is PrimaryWeapon:
			for availableWeapon in get_children():
				if weapon == availableWeapon:
					availableWeapon.queue_free()
			primaryWeapons.remove(primaryWeapons.find(GameManager.selectedPrimaryWeapon))
			changePrimaryWeapon()
		
	else:
		print("%s was never Mounted!" % weapon.name)

func replaceWeapon(newWeapon: Weapon):
	if newWeapon is PrimaryWeapon:
		print ("Replaced %s" % (GameManager.selectedPrimaryWeapon as PrimaryWeapon))
		var currentPrimaryWeapon: = GameManager.selectedPrimaryWeapon as PrimaryWeapon
		var tempAvailableCapacity = primaryWeaponCapacity + currentPrimaryWeapon.size
		if tempAvailableCapacity >= newWeapon.size:
			primaryWeapons[primaryWeapons.find(currentPrimaryWeapon)] = newWeapon
			print("With %s" % newWeapon as PrimaryWeapon)
			for weapon in get_children():
				if weapon == currentPrimaryWeapon:
					weapon.queue_free()
			add_child(newWeapon)
			newWeapon.isActive = true
			GameManager.selectedPrimaryWeapon = newWeapon
			
		else:
			print("Not Enough Primary Weapon Space")

func changePrimaryWeapon():
	var weaponIndex: = primaryWeapons.find(GameManager.selectedPrimaryWeapon)
	var alternateWeapon
	
	if not (weaponIndex - 1) < 0 :
		alternateWeapon = primaryWeapons[weaponIndex - 1]
	elif not (weaponIndex + 1) >= primaryWeapons.size():
		alternateWeapon = primaryWeapons[weaponIndex + 1]
	else:
		alternateWeapon = null
	
	if not alternateWeapon:
		GameManager.selectedPrimaryWeapon = null
		return
	
	if alternateWeapon.ammoAtHand <= 0 and alternateWeapon.ammoInGun <= 0:
		return
	
	print("Switching Weapon...")
	yield(get_tree().create_timer(data.PrimaryWeaponSwitchDuration), "timeout")
	GameManager.selectedPrimaryWeapon = alternateWeapon
	print ("Switched Weapon to: %s" % alternateWeapon.name)
