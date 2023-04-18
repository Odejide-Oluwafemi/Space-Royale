extends KinematicBody2D

class_name Ship

const DISTANCE_THRESHOLD = 10.0

enum ShipRarity {
	Common,
	Rare,
	Epic,
	Legendary
}
export(bool) var is_unlocked = false
export(ShipRarity) var rarity
export (NodePath) var EngineNode
export (NodePath) var ArmorNode
export (NodePath) var WeaponSystemNode
export (NodePath) var SpriteNode
export (NodePath) var BoosterSpriteNode
#export(int) var max_equipment_capacity = 200
export(float) var max_durability
export(float) var mass       = 1.0
export(float) var slow_radius = 280.0
export(float, 0, 3.5) var accuracy = 2.5
export(int) var max_upgrade_level = ((randi() % 10) + 1) * (rarity + 1)

onready var bulletSpawnPoint: Position2D = $BulletSpawnPoint
onready var markerAnchor: = $Markers/SafeZoneMarkerAnchor
onready var marker: = $Markers/SafeZoneMarkerAnchor/Marker

var level: = 1
var _direction:       = Vector2.ZERO
var velocity:        = Vector2.ZERO
var target_position: = Vector2.ZERO
var sprite: Sprite
var booster_sprite: AnimatedSprite
var engine
var armor: Armor
var weaponSystem
var durability
var outside_safe_zone: = false setget outta_safe_zone
var safeZone
#var equipment_capacity = max_equipment_capacity
var is_dead: = false

func outta_safe_zone(value):
	outside_safe_zone = value

func _process(_delta):
	if booster_sprite:
		booster_sprite.visible = engine.speed != 0

func _ready():
	durability = max_durability
	
	engine = get_node(EngineNode)
	sprite = get_node(SpriteNode)
	booster_sprite = get_node(BoosterSpriteNode)
	booster_sprite.play("default")
	armor  = get_node(ArmorNode)
	weaponSystem = get_node(WeaponSystemNode)
	weaponSystem.ship = self

func move(towards: Vector2, speed: float, ship_mass: float, slowRadius: = 0.0) -> Vector2:
	_direction = self.global_position.direction_to(towards)
	if self.global_position.distance_to(towards) < DISTANCE_THRESHOLD:
		return Vector2.ZERO
	
	var vel = Steering.steer(global_position, velocity, towards, speed, ship_mass, slowRadius)
	vel = move_and_slide(vel)
	return vel

func _physics_process(_delta):
	self.outside_safe_zone = sprite.light_mask == 2
	if outside_safe_zone and safeZone.should_damage:
		self.receive_damage(safeZone.zoneDamage)

func activate_special():
	print("Special Activated from General Ship Script")

func receive_damage(damage: float):
	if not armor.isDestroyed:
		armor.receive_damage(damage)
	else:
		durability -= damage
		durability = clamp(durability, 0, max_durability)
		
		if durability == 0:
			set_physics_process(false)
			if not $DeathSound.playing:
				$DeathSound.play()
				$Sprite/Explosion.show()
				$Sprite/Explosion.play("default")
			is_dead = true

func shoot_bullet(bullet: Bullet):
	var offset: = self.global_position.distance_to(bulletSpawnPoint.global_position)
	bullet.global_position = self.global_position + Vector2(offset, 0).rotated(_direction.angle())
	bullet.direction = _direction.rotated(deg2rad(rand_range(-accuracy, accuracy)))
	get_tree().current_scene.add_child(bullet)

#func mount(equipment: Item):
#	if equipment == null:
#		print("Null Equipment!")
#		return# false
#	if equipment.weight > equipment_capacity:
#		print("Not Enough Space to mount %s", equipment.Name)
#		return# false
#
#	if equipment is EngineResource:
#		engine.data = equipment
#	elif equipment is ArmorResource:
#		armor.data = equipment
#	elif equipment is RadarResource:
#		pass
#	elif equipment is WeaponSystemResource:
#		weaponSystem.data = equipment
#	else:
#		print("Invalid Equipment!")
#		return# false
#
#	equipment_capacity -= equipment.weight
#	print("%s Mount Successful: ", equipment.Name)
#	return# true


func _on_Explosion_animation_finished():
	queue_free()
