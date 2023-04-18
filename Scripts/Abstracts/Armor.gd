extends Node2D

class_name Armor

export(float) var max_armor
export(float) var regenerate_speed
export(float) var regen_inactive_time
export(float) var regen_value

var isDestroyed: = true
var armor setget _armor_updated
var regen_timer: Timer
var inactive_timer: Timer

func _armor_updated(value):
	armor = value
	armor = clamp(armor, 0, max_armor)
	isDestroyed = armor <= 0

func _ready():
	isDestroyed = false
	armor = max_armor
	regen_timer = Timer.new()
	regen_timer.wait_time = regenerate_speed
	regen_timer.one_shot = false
	regen_timer.autostart = false
	var regenTimeConnect = regen_timer.connect("timeout", self, "regenerate")
	assert (regenTimeConnect == OK)
	add_child(regen_timer)
	
	inactive_timer = Timer.new()
	inactive_timer.wait_time = regen_inactive_time
	inactive_timer.one_shot = false
	inactive_timer.autostart = false
	var inactiveTimeConnect = inactive_timer.connect("timeout", self, "regenerate_start")
	assert (inactiveTimeConnect == OK)
	add_child(inactive_timer)

func receive_damage(value: float):
	regen_timer.stop()
	
	if not inactive_timer.is_stopped():
		inactive_timer.stop()
	
	armor -= value
	armor = clamp(armor, 0, max_armor)
	if armor == 0:
		isDestroyed = true
	else:
		isDestroyed = false
	inactive_timer.start()
	

func regenerate():
	if armor < max_armor:
		armor += regen_value
		armor = clamp(armor, 0, max_armor)
		if armor == max_armor:
			inactive_timer.stop()
		if armor == 0:
			isDestroyed = true
		else:
			isDestroyed = false
		regen_timer.start()
	else:
		inactive_timer.stop()
	

func regenerate_start():
	if armor > 0:
		regen_timer.start()
