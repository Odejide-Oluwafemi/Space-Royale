extends Ship

class_name Player

func _ready():
	._ready()
	self.add_to_group("Player")
#	mount(GameManager.selectedArmorData)
#	mount(GameManager.selectedEngineData)
#	mount(GameManager.selectedWeaponSystemData)
	
#	if weaponSystem.data:
#		for pWeapon in GameManager.equippedPrimaryWeapons:
#			pWeapon = pWeapon as PrimaryWeapon
#
#			weaponSystem.addWeapon(pWeapon)

func _physics_process(_delta):
	if is_dead:
		self.queue_free()
		
	marker.visible = outside_safe_zone
	(markerAnchor as Position2D).look_at(safeZone.position)
	
	target_position = get_global_mouse_position()
#	if engine.data:
	if Input.is_action_pressed("forward"):
		engine.accelerate()
	elif Input.is_action_pressed("reverse"):
		engine.decelerate()
	else:
		engine.stop()
		
	velocity = move(target_position, engine.speed, mass)
	self.rotation = _direction.angle()
	
#	if weaponSystem.data:
	if Input.is_action_just_pressed("special"):
		activate_special()

	if weaponSystem.primaryWeapon:
		weaponSystem.primaryWeapon.shouldShoot = Input.is_action_pressed("fire_1")
