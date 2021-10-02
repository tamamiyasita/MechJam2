extends KinematicBody2D
onready var canon :Sprite = $Canon

export(PackedScene) var Bullet


func shoot() ->void:
	var b = Bullet.instance()
	add_child(b)
	b.transform = canon.transform


func _on_AttackArea_area_entered(area: Area2D) -> void:
	shoot()
