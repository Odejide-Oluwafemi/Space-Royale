extends Node2D

class_name Weapon

# warning-ignore:unused_signal
signal ammo_depleted

export(Resource) var data
export(float) var firingRate
export(float) var reloadSpeed
export(int) var ammoAtHand
export(int) var ammoExpendAmount: = 1
export(float) var size: = 25.0

onready var shootTimer: = $ShootTimer
onready var reloadTimer: = $ReloadTimer

var ship: Ship
var isActive: = false
var canShoot: = true
var ammoInGun: = 0

func _ready():
	shootTimer.wait_time = firingRate
	reloadTimer.wait_time = reloadSpeed
	_on_ReloadTimer_timeout()

func shoot():
	print ("Implement Shoot in Child Script!!!!!!!!!!!!")


func _on_ShootTimer_timeout():
	canShoot = true

func isReloading() -> bool:
	return not reloadTimer.is_stopped()

func reload():
	if not isReloading():
		reloadTimer.start()

func _on_ReloadTimer_timeout():
	var ammoToAdd = data.MagazineSize - ammoInGun
	ammoToAdd = min(ammoToAdd, ammoAtHand)
	ammoInGun += ammoToAdd
	ammoAtHand -= ammoToAdd
	

func addAmmo(amount: int):
	ammoAtHand = min(ammoAtHand + amount, data.MaxAmmoHoldable)
	
