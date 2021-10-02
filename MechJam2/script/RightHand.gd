extends Area2D


onready var right_fist :Area2D = $RightFist
onready var anime :AnimationPlayer = $AnimationPlayer

enum State {Ready, First_Move, Second_Move, Reach_Point, Return_Fist, Set_Pos}

export(State) var state = State.Ready


export(PackedScene) var Target_point_1
export(PackedScene) var Target_point_2
export(Resource) var right_point

onready var right_target = PathInfo.RightTarget
onready var right_target_point = right_point.right_point_list


var origin_transform
onready var origin_position = right_fist.position

signal point_reaching

func _init() -> void:
	set_physics_process(false)

func _ready() -> void:
	set_physics_process(true)
	anime.play('set_pos')


func _physics_process(delta: float) -> void:
	_get_input(delta)


func _get_input(delta) -> void:


	if Input.is_action_just_pressed('R_point_add'):
		if right_target_point.size() == 0 and state == State.Ready:
			get_parent().anime.play("R_shot")
			origin_transform = right_fist.global_transform
			origin_position = right_fist.position
			state = State.First_Move
			first_target_add()
		elif right_target_point.size() == 1:
			second_target_add()
			
	if state == State.Reach_Point:
		if right_target_point.size() == 2:
			second_move()	
		else:
			return_fist()
	if state == State.Second_Move:
		return_fist()
		
	if state == State.Set_Pos:
		if rotation_degrees == 90:
			anime.play('set_pos')
			yield(anime, "animation_finished" )
			state = State.Ready
			
#		look_at(right_target.global_position)
#		global_position = owner.global_position + origin_position



func return_fist() -> void:
	var return_pos = global_position.distance_to(right_fist.global_position)
	if abs(return_pos) < 20:
		right_fist.set_physics_process(false)
		right_fist.anime.play("default")
		right_fist.position = origin_position
		right_fist.global_position = global_position
		right_fist.global_transform = origin_transform
		right_target_point.clear()
		anime.play('default_pos')
		yield(anime, "animation_finished" )
		state = State.Set_Pos


func first_target_add() -> void:
	right_target_point.append(right_target.global_position)
	var target_position = right_target_point[0]
	var target_image = Target_point_1.instance() as Area2D
	get_parent().owner.add_child(target_image)
	target_image.global_position = target_position
	
	right_fist.start(self, target_position)

func second_target_add() -> void:
	right_target_point.append(right_target.global_position)
	var target_position = right_target_point[1]
	var target_image = Target_point_2.instance() as Area2D
	get_parent().owner.add_child(target_image)
	target_image.global_position = target_position

func second_move() -> void:
	state = State.Second_Move
	var target_position = right_target_point[1]
	right_fist.start(self, target_position)
	right_target_point.clear()
		
			
		


func _on_RightFist_area_entered(area: Area2D) -> void:
	if area.collision_layer == 32:
		state = State.Reach_Point
		right_fist.start(self, global_position)
		area.clear_point()
	elif area.collision_layer == 64 and state == State.Second_Move:
		right_fist.start(self, global_position)
		area.clear_point()



