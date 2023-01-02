extends Item

class_name ArmorResource

export(float) var max_armor
export(float) var regenerate_speed
export(float) var regen_inactive_time
export(float) var regen_value

var regen_timer: Timer
var inactive_timer: Timer
var isDestroyed: = false
