extends KinematicBody2D

onready var anime :AnimationPlayer = $shotAnimation

var speed = Vector2(1,1)
var velo = 1
#func _physics_process(delta: float) -> void:
#	if velo < 200:
#		velo += 1
#		move_and_slide((speed * velo))
