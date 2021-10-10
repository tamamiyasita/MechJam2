extends KinematicBody2D

onready var anime :AnimationPlayer = $shotAnimation
onready var damage_anime :AnimationPlayer = $DamageArea/AnimationPlayer
onready var Dmg_fire :Particles2D = $DPar
export(int) var HP = 7

var speed = Vector2(1,1)
var velo = 1
#func _physics_process(delta: float) -> void:
#	if velo < 200:
#		velo += 1
#		move_and_slide((speed * velo))

func _ready() -> void:
	HP += PathInfo.level
	$DamageArea/AnimationPlayer.play('start')
	yield($DamageArea/AnimationPlayer, "animation_finished" )
	
	$DamageArea/AnimationPlayer.play('end')
	yield($DamageArea/AnimationPlayer, "animation_finished" )
	yield(get_tree().create_timer(0.4), "timeout")
	anime.play('default')




func _on_DamageArea_area_entered(area: Area2D) -> void:
	if HP < 1:
		get_tree().change_scene("res://scene/GameOver.tscn")
	HP -= 1
	Dmg_fire.show()
	Dmg_fire.modulate.a8 += 15
	damage_anime.play('damage')
	


func _on_Timer_timeout() -> void:
	pass # Replace with function body.
