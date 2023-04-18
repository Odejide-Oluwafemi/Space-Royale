extends Area2D

export(float) var zoneDamage
export(float) var damageSpeed

onready var damageTimer: = $DamageTimer
onready var animPlayer: = $CanvasLayer/Control/AnimationPlayer
onready var warningLabel: = $CanvasLayer/Control/Label

var shipsOutOfZone: Array setget update_shipsOutOfZone
var should_damage: = false

var i = 1
var deg = 1

#func _draw():
#	draw_circle(self.position + Vector2($CollisionShape2D.shape.radius, 0).rotated((2 * PI) / deg * i), 50, Color.blue)
#	draw_circle(position, $CollisionShape2D.shape.radius*10, ColorN("Yellow", 0.04))
#	draw_circle(position, $CollisionShape2D.shape.radius, Color(ProjectSettings.get("rendering/environment/default_clear_color").r, ProjectSettings.get("rendering/environment/default_clear_color").g, ProjectSettings.get("rendering/environment/default_clear_color").b, 0.9))

func update_shipsOutOfZone(ship):
	if ship == null:
		shipsOutOfZone.remove(shipsOutOfZone.find(ship))
		return
	shipsOutOfZone.append(ship)
	show_warning_label()

func _ready():
	damageTimer.wait_time = damageSpeed
	animPlayer.play("RESET")

func _on_SafeZoneArea_body_exited(body):
	if not body is Ship:
		return
	shipsOutOfZone.append(body as Ship)
	(body as Ship).sprite.light_mask = 2
#	(body as Ship).light_mask = 2
	damageTimer.start()
	show_warning_label()

func _on_SafeZoneArea_body_entered(body):

	if body is Ship and shipsOutOfZone.has(body as Ship):
		(body as Ship).sprite.light_mask = 1
		(body as Ship).light_mask = 1
		shipsOutOfZone.remove(shipsOutOfZone.find(body))
		if shipsOutOfZone.empty():
			damageTimer.stop()
		show_warning_label()

func _on_Timer_timeout():
	should_damage = true
	yield(get_tree().create_timer(0.07), "timeout")
	should_damage = false
	damageTimer.start()
#	zoneDamage = rand_range(22.0, 42.0)
#	if shipsOutOfZone.empty():
#		damageTimer.stop()
#		return
#
#	for ship in shipsOutOfZone:
#		if ship == null:
#			return
#
#		ship.receive_damage(zoneDamage)

func show_warning_label():
	warningLabel.visible = GameManager.selectedShip in shipsOutOfZone
	if warningLabel.visible:
		if animPlayer.is_playing() and animPlayer.current_animation == "RadiationLabelAnim":
			return
		animPlayer.play("RadiationLabelAnim")
	else:
		animPlayer.play("RESET")

#func ship_destroyed(ship: Ship):
#	if not ship:
#		return
#
#	_on_SafeZoneArea_body_entered(ship)
