extends Path2D

onready var _path_follow : PathFollow2D = $PathFollow2D
onready var left_hand : KinematicBody2D = $PathFollow2D/LeftHand
onready var left_target  : Area2D = $PathFollow2D/LeftTarget

export(float, 0, 1, 0.001) var speeds
export(Curve) var speed_curve

var target := Vector2()
var velocity := Vector2()
var speed


func _ready() -> void:
	curve.clear_points()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed('L_click'):
		target = get_global_mouse_position()
	left_target.global_position = get_global_mouse_position()
#	left_hand.global_position = get_global_mouse_position()

func _process(delta: float) -> void:
	speed = speed_curve.interpolate(speeds)
	velocity = ((target - left_hand.global_position) * (speed)).normalized()
	left_hand.rotation = velocity.angle()
	if (target - left_hand.global_position).length() > 5:
#		velocity = left_hand.move_and_slide(velocity)
		left_hand.global_position += velocity*5

