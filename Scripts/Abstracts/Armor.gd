extends Node2D

class_name Armor

export(Resource) var data

var isDestroyed: = false
var armor setget armor_updated

func armor_updated(value):
	armor = value
	armor = clamp(armor, 0, data.max_armor)
	isDestroyed = armor <= 0

func _ready():
#	if not (data || GameManager.selectedArmorData):
#		isDestroyed = true
#		return
#	assert(GameManager.selectedArmorData is ArmorResource || data, "Armor Data Need to Be Set!")
	data = GameManager.selectedArmorData
	data = data if data else GameManager.selectedArmorData as ArmorResource
	armor = data.max_armor
	data.regen_timer = Timer.new()
	data.regen_timer.wait_time = data.regenerate_speed
	data.regen_timer.one_shot = false
	data.regen_timer.autostart = false
	var regenTimeConnect = data.regen_timer.connect("timeout", self, "regenerate")
	assert (regenTimeConnect == OK)
	get_parent().call_deferred("add_child", data.regen_timer)
	
	data.inactive_timer = Timer.new()
	data.inactive_timer.wait_time = data.regen_inactive_time
	data.inactive_timer.one_shot = false
	data.inactive_timer.autostart = false
	var inactiveTimeConnect = data.inactive_timer.connect("timeout", self, "regenerate_start")
	assert (inactiveTimeConnect == OK)
	get_parent().call_deferred("add_child", data.inactive_timer)

func receive_damage(value: float):
	data.regen_timer.stop()
	
	if not data.inactive_timer.is_stopped():
		data.inactive_timer.stop()
	
	armor -= value
	armor = clamp(armor, 0, data.max_armor)
	if armor == 0:
		isDestroyed = true
	else:
		isDestroyed = false
	data.inactive_timer.start()
	

func regenerate():
	if armor < data.max_armor:
		armor += data.regen_value
		armor = clamp(armor, 0, data.max_armor)
		if armor == data.max_armor:
			data.inactive_timer.stop()
		if armor == 0:
			isDestroyed = true
		else:
			isDestroyed = false
		data.regen_timer.start()
	else:
		data.inactive_timer.stop()
	

func regenerate_start():
	if armor > 0:
		data.regen_timer.start()
