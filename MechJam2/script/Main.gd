extends Node

onready var left_target :Area2D = $LeftTarget


var velocity = Vector2()
export(int) var speed = 250

export(Resource) var left_point

onready var left_target_point = left_point.left_point_list

func _physics_process(delta: float) -> void:
	_get_input(delta)


func _get_input(delta) -> void:
	velocity = Vector2()
	if Input.is_action_pressed('L_right'):
		velocity.x += 1
	if Input.is_action_pressed("L_left"):
		velocity.x -= 1
	if Input.is_action_pressed('L_up'):
		velocity.y -= 1
	if Input.is_action_pressed('L_down'):
		velocity.y += 1
	velocity = velocity.normalized() * speed
	left_target.global_position += (velocity * delta)
