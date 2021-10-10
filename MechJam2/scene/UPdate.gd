extends Control

var level = 1
func _ready() -> void:
	pass

func _on_Button_pressed() -> void:
	PathInfo.power_level += .5
	change_scene()
#	get_tree().call_group("fist", "update_level", "Power")


func _on_Button2_pressed() -> void:
	PathInfo.speed_level += .5
	change_scene()
#	get_tree().call_group("fist", "update_level", "Speed")

func change_scene() -> void:
	get_tree().change_scene("res://scene/Main.tscn")
