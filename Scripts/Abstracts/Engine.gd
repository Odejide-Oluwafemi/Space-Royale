extends Node2D

class_name Engine

export(float) var max_speed setget set_max_speed

var inertia
var speed: = .0

func set_max_speed(value):
	max_speed = value
	inertia = (2.0 * max_speed)

func accelerate():
	speed += inertia * get_physics_process_delta_time()
	speed = clamp(speed, -max_speed, max_speed)

func decelerate():
	speed -= inertia * get_physics_process_delta_time()
	speed = clamp(speed, -max_speed, max_speed)

func stop():
	if not (speed > -0.5 and speed < 0.5):
		if speed > 0:
			decelerate()
		else:
			accelerate()
	else:
		speed = 0
