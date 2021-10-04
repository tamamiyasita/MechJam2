extends Area2D

func _on_buil_5_area_entered(area: Area2D) -> void:
	if area.collision_layer == 256 or area.collision_layer == 512:
		$AnimationPlayer.play('bom')
