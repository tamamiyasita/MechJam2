extends Area2D



func _on_Barrier_area_entered(area: Area2D) -> void:
	if modulate.a8 < 30:
		queue_free()
	modulate.a8 -= 20
