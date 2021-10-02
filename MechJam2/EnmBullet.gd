extends Area2D

var speed = 500


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_EnmBullet_body_entered(body: Node) -> void:
	if body.is_in_group("buil"):
		body.queue_free()
	queue_free()
