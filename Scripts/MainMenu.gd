extends Control

func _ready():
	$AnimationPlayer.play("RESET")
	if not GameManager.selectedShip:
		GameManager.selectedShip = GameManager.DEFAULT_SHIP

func _on_Play_button_up():
	yield(get_tree().create_timer(0.8), "timeout")
	assert(get_tree().change_scene("res://Scenes/BattleGround.tscn") == OK)


func _on_Hanger_button_up():
	
	$AnimationPlayer.play("TransitionIn(Hangar)")

func transition_to(scene: String):
	assert(get_tree().change_scene(scene) == OK)


func _on_Host_button_up():
	pass # Replace with function body.


func _on_Join_button_up():
	pass # Replace with function body.
