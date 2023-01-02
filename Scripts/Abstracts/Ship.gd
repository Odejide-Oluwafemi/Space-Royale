extends KinematicBody2D

class_name Ship

export (Resource) var ResourceData
export (NodePath) var EngineNode
export (NodePath) var ArmorNode
export (NodePath) var WeaponSystemNode
export (NodePath) var SpriteNode

onready var bulletSpawnPoint: Position2D = $BulletSpawnPoint
onready var data: = load(ResourceData.resource_path) as ShipResource

var direction:       = Vector2.ZERO
var velocity:        = Vector2.ZERO
var target_position: = Vector2.ZERO
var engine
var sprite
var armor
var weaponSystem
var durability

func _ready():
	engine = get_node(EngineNode)
	sprite = get_node(SpriteNode)
	armor  = get_node(ArmorNode) as Armor
	weaponSystem = get_node(WeaponSystemNode)
	durability = data.MaxDurability
	$Components/WeaponSystem.ship = self
	

func move(towards: Vector2, speed: float, mass: float, slowRadius: = 0.0) -> Vector2:
	direction = self.global_position.direction_to(towards)
	if self.global_position.distance_to(towards) < data.DISTANCE_THRESHOLD:
		return Vector2.ZERO
	
	var vel = Steering.steer(global_position, velocity, towards, speed, mass, slowRadius)
	vel = move_and_slide(vel)
	return vel

func _physics_process(_delta):
	if Input.is_action_pressed("forward"):
		engine.accelerate()
	elif Input.is_action_pressed("reverse"):
		engine.decelerate()
	else:
		engine.stop()
	target_position = get_global_mouse_position()
	velocity = move(target_position, engine.data.speed, data.Mass)
	self.rotation = direction.angle()
	
	if Input.is_action_just_pressed("special"):
		activate_special()

func activate_special():
	print("Special Activated from General Ship Script")

func receive_damage(damage: float):
	if not armor.isDestroyed:
		armor.receive_damage(damage)
		
	else:
		durability -= damage
		durability = clamp(durability, 0, data.MaxDurability)
		
		if durability == 0:
			queue_free()

func shoot_bullet(bullet: Bullet):
	var offset: = self.global_position.distance_to(bulletSpawnPoint.global_position)
	bullet.position = self.global_position + Vector2(offset, 0).rotated(direction.angle())
	bullet.direction = direction
	get_tree().current_scene.add_child(bullet)
