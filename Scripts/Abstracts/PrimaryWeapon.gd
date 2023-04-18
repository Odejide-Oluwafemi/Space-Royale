extends Weapon

class_name PrimaryWeapon

func _physics_process(_delta):
	if shouldShoot and isActive and canShoot and ship.weaponSystem.primaryWeapon:
		shoot()
		canShoot = false
		shootTimer.start()

func _ready():
	._ready()
	assert(ship.weaponSystem.connect("primary_weapon_changed", self, "updateActiveStatus") == OK)

func updateActiveStatus(primaryWeapon: PrimaryWeapon):
	isActive = primaryWeapon == self
