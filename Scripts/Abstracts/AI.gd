extends Ship

class_name AI

const STOP_DISTANCE: = 400.0

onready var wander_timer: = $WanderTimer

var inactive_time: float = rand_range(0.5, 0.8)
var should_retreat: = false
var target = null
var distance_to_target
var shoot_distance: = 1500.0
var wander_direction: Vector2
var move_to: Vector2
var last_vec: Vector2

#func get_random(type: String):
#	var items: = []
#
#	for item in Inventory.resourceData[type]:
#		item = Inventory.resourceData[type].get(item)
#		items.append(item)
#	items.shuffle()
#	var selected_item = items.front()
#	return selected_item
#
#func get_random2(val: String):
#	var weapons: = []
#
#	for weapon in Inventory.objectScenes["Weapon"][val]:
#		weapon = Inventory.objectScenes["Weapon"][val].get(weapon)
#		weapons.append(weapon)
#	weapons.shuffle()
#	var selected_weapon = weapons.front()
#	self.target = get_tree().get_nodes_in_group("Player").front()
#	return selected_weapon.instance()

func _ready():
	set_physics_process(false)
	yield(get_tree().create_timer(inactive_time) ,"timeout")
	set_physics_process(true)
	
	randomize()
#	target = get_tree().get_nodes_in_group("Player").front()
#	max_durability = int(rand_range(3500, 6000))
	mass       = rand_range(1.0, 5.0)
	slow_radius = rand_range(230, 330)
	._ready()
	
#	mount(get_random("Armor"))
#	mount(get_random("Engine"))
#	mount(get_random("WeaponSystem"))
	
	
#	var weapon_count: = (randi() % 3) + 1
#	if weaponSystem.data:
#		var count = 0
#		while count <= weapon_count:
#			var pWeapon: PrimaryWeapon = get_random2("Primary")
#			pWeapon.ship = self
#			weaponSystem.addWeapon(pWeapon)
#			count += 1

	self.add_to_group("AI")

func _physics_process(_delta):
	if is_dead:
		self.queue_free()
	
	if target == null:
		move_to = last_vec * 100
		if weaponSystem.primaryWeapon.shouldShoot:
			weaponSystem.primaryWeapon.shouldShoot = false
		wander()
	else:
		target_position = target.global_position
		distance_to_target = self.global_position.distance_to(target_position)
		move_to = target_position
		if target is Ship and target.is_dead:
			target = null if not outside_safe_zone else safeZone
		
		_logic()
	
	velocity = move(move_to, engine.speed, mass)
	last_vec = last_vec if velocity == Vector2.ZERO else velocity
	self.rotation = _direction.angle()

func _logic():
	if not target:
		return
	
	if distance_to_target >= STOP_DISTANCE:
		engine.accelerate()
	else:
		engine.stop()

#	# Engage or Retreat When Low on Armor
#	if (armor.armor <= 500.0 or durability <= 750.0):
#		die_hard = (randi() % 2) as bool
#		if not die_hard:
#			if die_hard:
#				engine.accelerate()
#			if armor.armor <= 350.0 or durability <= 500.0:
#				die_hard = false
#			else:
#				engine.decelerate()
#	else:
#		die_hard = false

	
	# Should Shoot
#	if weaponSystem.data:
	weaponSystem.primaryWeapon.shouldShoot = (distance_to_target <= shoot_distance) and (weaponSystem.primaryWeapon) and (weaponSystem.primaryWeapon.hasAmmo() and weaponSystem.primaryWeapon.canShoot) and target is Ship
	if weaponSystem.primaryWeapon.shouldShoot:
		weaponSystem.primaryWeapon.shoot()
		weaponSystem.primaryWeapon.shootTimer.start()



func _on_EnemyDetectionArea_body_entered(body):
	if not target == null or body.is_in_group("AI"):
		return
	
	target = body
	wander_direction = Vector2.ZERO


func _on_EnemyDetectionArea_body_exited(body):
	if body == target:
		target = null if not outside_safe_zone else safeZone

func wander():
	engine.accelerate()
	if outside_safe_zone:
		target = safeZone
		
	if wander_timer.is_stopped():
		wander_timer.wait_time = rand_range(1.5, 3)
		wander_timer.start()

func _on_WanderTimer_timeout():
	wander_direction = Vector2(randf(), randf()).normalized()
	move_to = global_position + wander_direction
