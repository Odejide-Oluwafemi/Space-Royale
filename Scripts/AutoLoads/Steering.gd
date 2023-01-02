extends Node

static func steer(
	global_pos:  Vector2,
	current_vel: Vector2,
	target_pos:  Vector2,
	speed: float,
	mass: float,
	slow_radius: float = 0.0
	) -> Vector2:
	
	var to_target: = global_pos.distance_to(target_pos)
	var final_velocity: = (target_pos - global_pos).normalized() * speed
	if (to_target < slow_radius):
		#final_velocity = final_velocity.move_toward(final_velocity / 2, 0.7)
		final_velocity *= (to_target / slow_radius) * 0.8 + 0.2
	var steer_vec: = (final_velocity - current_vel) / mass
	return current_vel + steer_vec
