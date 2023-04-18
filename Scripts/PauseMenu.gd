extends Control

func _on_Resume_button_up():
	assert(get_parent().has_method("resumed_pause"), "No Resume Method in " + get_parent().name)
	$AnimationPlayer.play("outro")


func _on_Main_Menu_button_up():
	yield(get_tree().create_timer(0.8), "timeout")
	assert(get_tree().change_scene("res://Scenes/MainMenu.tscn") == OK)
