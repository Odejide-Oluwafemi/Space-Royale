extends Weapon

class_name PrimaryWeapon

func _physics_process(_delta):
	if Input.is_action_pressed("fire_1") and isActive and canShoot and GameManager.selectedPrimaryWeapon == self:
		shoot()
		canShoot = false
		shootTimer.start()

func _ready():
	._ready()
	assert(GameManager.connect("primary_weapon_changed", self, "updateActiveStatus") == OK)

func updateActiveStatus(primaryWeapon: PrimaryWeapon):
	isActive = primaryWeapon == self
