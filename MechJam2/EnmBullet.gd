extends Area2D

var speed = 50
onready var anime :AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_EnmBullet_body_entered(body: Node) -> void:
	anime.play('bom')
	yield(anime, "animation_finished" )
	queue_free()


func _on_EnmBullet_area_entered(area: Area2D) -> void:
	set_physics_process(false)
	anime.play('bom')
	yield(anime, "animation_finished" )
	queue_free()
