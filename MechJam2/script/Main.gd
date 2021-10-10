extends Node

onready var left_target :Area2D = $LeftTarget
onready var right_target :Area2D = $RightTarget

export(PackedScene) var LEVEL_1
export(PackedScene) var LEVEL_2
export(PackedScene) var LEVEL_3
export(PackedScene) var LEVEL_4

var left_velocity = Vector2()
var right_velocity = Vector2()
var enemies
var level

export(int) var speed = 250

export(Resource) var left_point
export(Resource) var right_point

onready var left_target_point = left_point.left_point_list
onready var right_target_point = right_point.right_point_list

onready var change_window :AnimationPlayer = $CanvasLayer/Control/AnimationPlayer

func _ready() -> void:
#	change_window.play('change')
	
	level_update()
	print(enemies)
	
func level_update() -> void:
	var value = PathInfo.level
	if value == 1:
		level = LEVEL_1.instance()
		add_child(level)
		enemies = enemy_count()
		print(enemies)
	elif value == 2:
		level = LEVEL_2.instance()
		add_child(level)
		enemies = enemy_count()
		print(enemies)
	elif value == 3:
		level = LEVEL_3.instance()
		add_child(level)
		enemies = enemy_count()
		print(enemies)
	elif value == 4:
		level = LEVEL_4.instance()
		add_child(level)
		enemies = enemy_count()
		print(enemies)

func enemy_count()-> int:
	return level.enemies.get_child_count()

func dead_enemy() -> void:
	enemies -= 1
	if enemies < 1:
		print("level_clear")
		PathInfo.level +=1
		if PathInfo.level == 5:
			print("end")
			change_window.play('change')
			yield(change_window, "animation_finished" )
			get_tree().change_scene("res://scene/END_GAME.tscn")
		else:
			change_window.play('change')
			yield(change_window, "animation_finished" )
			get_tree().change_scene("res://scene/UPdate.tscn")
	print(enemies)



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
