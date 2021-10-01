extends Area2D

#onready var left_joint :Area2D = $Ljoint

onready var left_fist :Area2D = $LeftFist
onready var anime :AnimationPlayer = $AnimationPlayer

enum State {Ready, First_Move, Second_Move, Reach_Point, Return_Fist, Default_Pos}

export(State) var state = State.Ready


export(PackedScene) var Target_point_1
export(PackedScene) var Target_point_2
export(Resource) var left_point

onready var left_target = PathInfo.LeftTarget
onready var left_target_point = left_point.left_point_list


var origin_transform
onready var origin_position = left_fist.position

signal point_reaching

func _init() -> void:
	set_physics_process(false)

func _ready() -> void:
	set_physics_process(true)
	anime.play('default_pos')


func _physics_process(delta: float) -> void:
	_get_input(delta)


func _get_input(delta) -> void:


	if Input.is_action_just_pressed('L_point_add'):
		if left_target_point.size() == 0 and state == State.Ready:
			origin_transform = left_fist.global_transform
			origin_position = left_fist.position
			state = State.First_Move
			first_target_add()
		elif left_target_point.size() == 1:
			second_target_add()
			
	if state == State.Reach_Point:
		if left_target_point.size() == 2:
			second_move()	
		else:
			return_fist()
	if state == State.Second_Move:
		return_fist()
		
	if state == State.Ready:
		look_at(left_target.global_position)
#		global_position = owner.global_position + origin_position



func return_fist() -> void:
	var return_pos = global_position.distance_to(left_fist.global_position)
	if abs(return_pos) < 20:
		left_fist.set_physics_process(false)
		left_fist.anime.play("default")
		left_fist.global_transform = origin_transform
		left_fist.position = origin_position
		left_target_point.clear()
		anime.play('default_pos')
		yield(anime, "animation_finished" )
		state = State.Ready


func first_target_add() -> void:
	left_target_point.append(left_target.global_position)
	var target_position = left_target_point[0]
	var target_image = Target_point_1.instance() as Area2D
	get_parent().owner.add_child(target_image)
	target_image.global_position = target_position
	
	left_fist.start(get_parent().owner, target_position)

func second_target_add() -> void:
	left_target_point.append(left_target.global_position)
	var target_position = left_target_point[1]
	var target_image = Target_point_2.instance() as Area2D
	get_parent().owner.add_child(target_image)
	target_image.global_position = target_position

func second_move() -> void:
	state = State.Second_Move
	var target_position = left_target_point[1]
	left_fist.start(self, target_position)
	left_target_point.clear()
		
			
		


func _on_LeftFist_area_entered(area: Area2D) -> void:
	if area.collision_layer == 8:
		state = State.Reach_Point
		left_fist.start(self, global_position)
		area.clear_point()
	elif area.collision_layer == 16 and state == State.Second_Move:
		left_fist.start(self, global_position)
		area.clear_point()



