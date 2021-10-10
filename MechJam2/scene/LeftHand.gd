extends Area2D

#onready var left_joint :Area2D = $Ljoint

onready var left_fist :Area2D = $LeftFist
onready var anime :AnimationPlayer = $AnimationPlayer

enum State {Start, Ready, First_Move, Second_Move, Reach_Point, Return_Fist, Set_Pos}

export(State) var state = State.Start


export(PackedScene) var Target_point_1
export(PackedScene) var Target_point_2
export(Resource) var left_point

onready var left_target = get_node("/root/Main").find_node("LeftTarget", true)
onready var left_target_point = left_point.left_point_list


var origin_transform
onready var origin_position = left_fist.position

signal point_reaching

func _init() -> void:
	set_physics_process(false)

func _ready() -> void:
	set_physics_process(true)
	anime.play('default_pos')
	yield(anime, "animation_finished" )
	anime.play('charge')
	yield(anime, "animation_finished" )
	state = State.Ready
	


func _physics_process(delta: float) -> void:
	_get_input(delta)


func _get_input(delta) -> void:


	if Input.is_action_just_pressed('L_point_add'):
		if left_target_point.size() == 0 and state == State.Ready:
			get_parent().anime.play("L_shot")
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
		
	if state == State.Set_Pos:
		if rotation_degrees == -90:
			anime.play('charge')
			yield(anime, "animation_finished" )
			state = State.Ready
			
#		look_at(left_target.global_position)
#		global_position = owner.global_position + origin_position



func return_fist() -> void:
	var return_pos = global_position.distance_to(left_fist.global_position)
	if abs(return_pos) < 20:
		left_fist.set_physics_process(false)
		left_fist.anime.play("default")
		left_fist.position = origin_position
#		left_fist.rotation = rotation
		left_fist.rotation_degrees = 0
#		left_fist.global_position = global_position
#		left_fist.global_transform =global_transform# origin_transform
		left_target_point.clear()
		anime.play('default_pos')
		yield(anime, "animation_finished" )
		state = State.Set_Pos


func first_target_add() -> void:
	left_target_point.append(left_target.global_position)
	var target_position = left_target_point[0]
	var target_image = Target_point_1.instance() as Area2D
	get_parent().owner.add_child(target_image)
	target_image.global_position = target_position
	anime.play('set_pos')
	yield(anime, "animation_finished" )
	
	left_fist.start(self, target_position)

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



