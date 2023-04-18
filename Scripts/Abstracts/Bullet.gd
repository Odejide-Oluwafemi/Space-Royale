extends Area2D

class_name Bullet

onready var lifeTimer: = $LifeTimer

var direction: Vector2
export(float) var length_duration
export(float) var damage
export(float) var travelSpeed

func _ready():
	rotation = direction.angle()
	lifeTimer.wait_time = abs(length_duration)

func _physics_process(delta):
	position += direction * travelSpeed * delta

func _on_Bullet_body_entered(body):
	if body.has_method("receive_damage"):
		body.receive_damage(damage)
	queue_free()


func _on_LifeTimer_timeout():
	queue_free()
