extends Control

func _ready() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	yield(get_tree().create_timer(0.8), "timeout")
	get_tree().change_scene("res://scene/Title.tscn")
