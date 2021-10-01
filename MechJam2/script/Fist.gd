extends Area2D
class_name Fist

export var speed := 120
export var steer_force := 30.0

onready var anime :AnimationPlayer = $AnimationPlayer

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null
var parent

func _ready() -> void:
	set_physics_process(false)
	anime.play('default')

func start(_parent, _target) -> void:
#	set_as_toplevel(true)
	set_physics_process(true)
	parent = _parent
	acceleration = _target
	global_rotation += rand_range(-0.09, 0.09)
	velocity = global_transform.x * speed
	target = _target
	anime.play('fire')


func seek():
	var steer = Vector2.ZERO
	if target:
		var desired:Vector2 = (target - global_position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer

	
func _physics_process(delta: float) -> void:
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	global_rotation = velocity.angle()
	global_position += velocity * delta



func _on_Hand_body_entered(body: Node) -> void:
	print(body, "hand t")


func _on_Timer_timeout() -> void:
	pass # Replace with function body.


#func _on_LeftHand_area_entered(area: Area2D) -> void:
#	start(parent, parent.global_position)
#	pass


func _on_LeftFist_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		anime.play('default')
