extends Node2D

class_name Radar

export(Resource) var data setget set_data
export(NodePath) var ScanAreaNode
export(NodePath) var ScanAreaCollisionNode

var scanArea: Area2D
var scanCol: CollisionShape2D
var minimap: ViewportContainer
var ship: Ship

var bodies: Array
var areas: Array
var isActive: = true setget toggle_minimap

func set_data(value):
	data = value
	
	if not data:
		return
	setup()

func setup():
	scanCol = get_node(ScanAreaCollisionNode)
	minimap = $CanvasLayer/Minimap
#	ship = get_tree().current_scene.find_node("NightHawk")
	scanArea = get_node(ScanAreaNode)
	
	scanCol.shape = CircleShape2D.new()
	scanCol.shape.radius = (data as RadarResource).ScanRadius
	minimap.player = ship
	minimap.radar = self
	minimap.setup()
	

func toggle_minimap(value):
	isActive = value
	$CanvasLayer/Minimap.visible = isActive

func _on_Body_Entered(body):
	bodies.append(body)
	minimap.update()

func _on_Body_Exited(body):
	bodies.remove(bodies.find(body))
	minimap.update()

func _on_Area_Entered(area):
	areas.append(area)

func _on_Area_Exited(area):
	areas.remove(areas.find(area))
