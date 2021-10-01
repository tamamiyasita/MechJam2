extends Node

onready var left_target :Area2D = $LeftTarget
onready var right_target :Area2D = $RightTarget


var left_velocity = Vector2()
var right_velocity = Vector2()

export(int) var speed = 250

export(Resource) var left_point
export(Resource) var right_point

onready var left_target_point = left_point.left_point_list
onready var right_target_point = right_point.right_point_list

func _physics_process(delta: float) -> void:
	_get_input(delta)


func _get_input(delta) -> void:
	left_velocity = Vector2()
	if Input.is_action_pressed('L_right'):
		left_velocity.x += 1
	if Input.is_action_pressed("L_left"):
		left_velocity.x -= 1
	if Input.is_action_pressed('L_up'):
		left_velocity.y -= 1
	if Input.is_action_pressed('L_down'):
		left_velocity.y += 1
	left_velocity = left_velocity.normalized() * speed
	left_target.global_position += (left_velocity * delta)

	right_velocity = Vector2()
	if Input.is_action_pressed('R_right'):
		right_velocity.x += 1
	if Input.is_action_pressed("R_left"):
		right_velocity.x -= 1
	if Input.is_action_pressed('R_up'):
		right_velocity.y -= 1
	if Input.is_action_pressed('R_down'):
		right_velocity.y += 1
	right_velocity = right_velocity.normalized() * speed
	right_target.global_position += (right_velocity * delta)
