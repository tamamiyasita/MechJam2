extends Path2D

onready var _path_follow: PathFollow2D = $PathFollow2D
onready var left_hand : KinematicBody2D = $PathFollow2D/LeftHand


func _ready() -> void:
	curve.clear_points()
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var point :Vector2 = event.position
		curve.clear_points()
		curve.add_point(point)

func _process(delta: float) -> void:
	left_hand.move_and_slide(curve.get_point_position(0))
