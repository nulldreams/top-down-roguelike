extends RigidBody2D

const CAST_VELOCITY = Vector2(400, 0)
export var life_time = 2
export var arrow_damage = 10
export var caster = ""

var velocity = Vector2.ZERO
var angle = null

onready var life_timer = $LifeTimer

func _ready():
	set_as_toplevel(true)
	_lunch_arrow()

func _lunch_arrow():
	apply_impulse(Vector2(), Vector2(CAST_VELOCITY).rotated(rotation))
	angle = Vector2(CAST_VELOCITY).rotated(rotation)
	life_timer.wait_time = life_time
	life_timer.start()

func SelfDestruct():
	queue_free()

func _on_LifeTimer_timeout():
	SelfDestruct()

func _on_hitbox_body_entered(body):
	var knockbak_direction = (global_position - body.global_position).normalized()
	var knockback_range = knockbak_direction * 20000
	if body.is_in_group("players") and body.name != caster:
		body.rpc("hit", angle, knockback_range * Vector2(-1, -1))
		queue_free()
