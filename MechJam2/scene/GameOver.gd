extends Control

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	get_tree().change_scene("res://scene/Main.tscn")
