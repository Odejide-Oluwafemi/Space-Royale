extends Node2D

class_name Engine

export(Resource) var data

func _ready():
#	assert(GameManager.selectedEngineData is EngineResource || data, "Engine Data Needs to Be Set!")
#	data = load(data.resource_path) as EngineResource if data else GameManager.selectedEngineData as EngineResource
	data = GameManager.selectedEngineData as EngineResource
	data.inertia = (2.0 * data.max_speed)

func accelerate():
	data.speed += data.inertia * get_physics_process_delta_time()
	data.speed = clamp(data.speed, -data.max_speed, data.max_speed)

func decelerate():
	data.speed -= data.inertia * get_physics_process_delta_time()
	data.speed = clamp(data.speed, -data.max_speed, data.max_speed)

func stop():
	if not (data.speed > -0.5 and data.speed < 0.5):
		if data.speed > 0:
			decelerate()
		else:
			accelerate()
	else:
		data.speed = 0
	
