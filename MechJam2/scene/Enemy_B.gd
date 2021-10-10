extends KinematicBody2D


onready var canon :Sprite = $Canon
onready var timer :Timer = $Timer
onready var anime :AnimationPlayer = $AnimationPlayer
onready var audio :AudioStreamPlayer = $AudioStreamPlayer

var tar_point = Vector2(790, 368)
var velo = Vector2.ZERO
var speed = 20
var target

export(PackedScene) var Bullet

func _init() -> void:
	set_physics_process(false)

func _ready() -> void:
#	velo = velo.normalized() * speed
	pass

func _physics_process(delta: float) -> void:
	velo = Vector2.ZERO
	if target == null:
		var v = tar_point - global_position
		var angle = v.angle()
		var r = global_rotation
		rotation = lerp_angle(r, angle, .02)
		velo += (transform.x * speed)
		move_and_slide(velo)
		#		canon.look_at(target.global_position)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed('L_click'):
		shoot()
	

func shoot() ->void:
	var b = Bullet.instance()
	b.position.x += 1
	b.speed = 7
	add_child(b)
	audio.play()



func _on_AttackArea_area_entered(area: Area2D) -> void:
	target = area
	set_physics_process(true)
	yield(get_tree().create_timer(1.1), "timeout")
	shoot()
	timer.start(7)

func _on_Timer_timeout() -> void:
	shoot()
	timer.start(7)


func _on_DamageArea_area_entered(area: Area2D) -> void:
	get_tree().call_group("main", "dead_enemy")
	anime.play('bom')
