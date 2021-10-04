extends KinematicBody2D

onready var anime :AnimationPlayer = $shotAnimation
onready var damage_anime :AnimationPlayer = $DamageArea/AnimationPlayer
export(int) var HP = 7

var speed = Vector2(1,1)
var velo = 1
#func _physics_process(delta: float) -> void:
#	if velo < 200:
#		velo += 1
#		move_and_slide((speed * velo))

func _ready() -> void:
	anime.play('default')




func _on_DamageArea_area_entered(area: Area2D) -> void:
	if HP < 1:
		queue_free()
	HP -= 1
	damage_anime.play('damage')
	


func _on_Timer_timeout() -> void:
	pass # Replace with function body.
