extends Area2D

#onready var left_joint :Area2D = $Ljoint
onready var left_fist :Area2D = $LeftFist
onready var left_target :Area2D = $LeftTarget

enum State {Ready, Move_Point, Reach_Point, Move_Return}

export(State) var state = State.Ready

export(int) var speed = 250

export(PackedScene) var Target_point_1
export(PackedScene) var Target_point_2

var left_target_point :PoolVector2Array = []
var velocity = Vector2()

signal point_reaching


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
	
	if state == State.Ready:
		if Input.is_action_just_pressed('L_point_add'):
			shot_target()
		
#	left_joint.look_at(left_target.global_position)


func shot_target() -> void:
	if left_target_point.size() < 2:
		left_target_point.append(left_target.global_position)
		var target = left_target_point[0]
		var target_point = Target_point_1.instance() as Area2D
		get_parent().add_child(target_point)
		target_point.global_position = target
		left_fist.start(self, target)
		left_target_point.remove(0)
		state = State.Move_Point


func _physics_process(delta: float) -> void:
	_get_input(delta)
