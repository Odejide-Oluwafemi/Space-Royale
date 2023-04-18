extends Node2D

class_name Weapon

# warning-ignore:unused_signal
signal ammo_depleted

export(PackedScene) var bullet_scene
export(int) var max_ammo_holdable
export(int) var magazine_size
export(int) var ammoAtHand
export(int) var ammoExpendAmount: = 1
export(float) var firingRate
export(float) var reloadSpeed
export(bool) var is_unlocked: = false
export(Texture) var thumbnail
export(String) var weapon_name

onready var shootTimer: = $ShootTimer
onready var reloadTimer: = $ReloadTimer

var ship: Ship
var isActive: = false
var canShoot: = true
var ammoInGun: = 0
var shouldShoot: = false

func _ready():
	shootTimer.wait_time = firingRate
	reloadTimer.wait_time = reloadSpeed
	_on_ReloadTimer_timeout()
	
	if weapon_name == "":
		weapon_name = name

func shoot():
	$ShootSound.play()


func _on_ShootTimer_timeout():
	canShoot = true

func isReloading() -> bool:
	return not reloadTimer.is_stopped()

func reload():
	if not isReloading():
		reloadTimer.start()

func _on_ReloadTimer_timeout():
	var ammoToAdd = magazine_size - ammoInGun
	ammoToAdd = min(ammoToAdd, ammoAtHand)
	ammoInGun += ammoToAdd
	ammoAtHand -= ammoToAdd
	

func addAmmo(amount: int):
	ammoAtHand = min(ammoAtHand + amount, max_ammo_holdable)
	
func hasAmmo() -> bool:
	return ammoAtHand > 0 or ammoInGun > 0
