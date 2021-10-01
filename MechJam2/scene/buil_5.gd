extends Area2D



var is_rubble := false


func _on_buil_5_area_entered(area: Area2D) -> void:
	if !is_rubble:
		$AnimationPlayer.play('bom')
		is_rubble = true
