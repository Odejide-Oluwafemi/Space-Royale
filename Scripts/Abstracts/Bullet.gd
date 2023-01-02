extends Area2D

class_name Bullet

export(Resource) var data

onready var lifeTimer: = $LifeTimer

var direction: = Vector2.ZERO

func _ready():
	assert(direction != Vector2.ZERO)
	lifeTimer.wait_time = abs(data.LengthOrDuration)
	lifeTimer.start()
	

func _physics_process(delta):
	position += direction * data.TravelSpeed * delta


func _on_Bullet_body_entered(body):
	body.receive_damage(data.Damage)
	queue_free()


func _on_LifeTimer_timeout():
	queue_free()
