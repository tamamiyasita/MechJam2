extends KinematicBody2D
onready var canon :Sprite = $Canon
onready var timer :Timer = $Timer
onready var anime :AnimationPlayer = $AnimationPlayer


var velo = -30
var speed = Vector2.DOWN
var target

export(PackedScene) var Bullet

func _init() -> void:
	set_physics_process(false)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if target != null:
		var v = target.global_position - canon.global_position
		var angle = v.angle()
		var r = canon.global_rotation
		canon.global_rotation = lerp(r, angle, .02)
#		canon.look_at(target.global_position)
	else:
		move_and_slide(speed * velo)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_pressed('L_click'):
		shoot()
	

func shoot() ->void:
	var b = Bullet.instance()
	b.position.x += 10
	canon.add_child(b)



func _on_AttackArea_area_entered(area: Area2D) -> void:
	target = area
	set_physics_process(true)
	yield(get_tree().create_timer(1.1), "timeout")
	shoot()
	timer.start(5)

func _on_Timer_timeout() -> void:
	shoot()
	timer.start(5)


func _on_DamageArea_area_entered(area: Area2D) -> void:
	anime.play('bom')
