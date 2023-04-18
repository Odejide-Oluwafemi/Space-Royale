extends ViewportContainer

onready var viewport: = $Viewport
onready var camera: = $Viewport/Camera2D

var player: PhysicsBody2D
var radar: Radar

func _ready():
	viewport.size = rect_size
	viewport.add_child(get_tree().current_scene.get_child(2).duplicate())

func setup():
	$Viewport/Sprite.scale = Vector2(3.8, 3.8)

func _process(_delta):
	$Viewport/Sprite.position = $Viewport/Camera2D.get_camera_screen_center()
	if player:
		camera.position = player.global_position
	
func update():
	for child in viewport.get_children():
		if child is Camera2D or child is Sprite:
			continue
		child.queue_free()
	
	for body in radar.bodies:
		if body in get_children():
			continue
		body = body.duplicate()
		body.scale = Vector2(3.8, 3.8)
		viewport.call_deferred("add_child", body)
