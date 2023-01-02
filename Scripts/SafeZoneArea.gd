extends Area2D

export(float) var zoneDamage
export(float) var damageSpeed

onready var damageTimer: = $DamageTimer
onready var animPlayer: = $CanvasLayer/Control/AnimationPlayer
onready var warningLabel: = $CanvasLayer/Control/Label

var shipsOutOfZone: Array setget shipInZone

func shipInZone(ship):
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
	(body as Ship).light_mask = 2
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
	if shipsOutOfZone.empty():
		return
	
	for ship in shipsOutOfZone:
		(ship as Ship).receive_damage(zoneDamage)

func show_warning_label():
	warningLabel.visible = GameManager.selectedShip in shipsOutOfZone
	if warningLabel.visible:
		if animPlayer.is_playing() and animPlayer.current_animation == "RadiationLabelAnim":
			return
		animPlayer.play("RadiationLabelAnim")
	else:
		animPlayer.play("RESET")
