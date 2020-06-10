extends Node2D

export var weapon_owner = ""
export var weapon_texture = "sword"
onready var sprite = $Area2D/Sprite
onready var bow = $Area2D/Bow
onready var animation_player = $Area2D/animation_player

func _ready():
	sprite.texture = load(WeaponsMap.weapon_list[weapon_texture])

func _physics_process(delta):
	sprite.texture = load(WeaponsMap.weapon_list[weapon_texture])
	if weapon_texture == "bow":
		bow.visible = true
		sprite.visible = false
	else:
		bow.visible = false
		sprite.visible = true

func _on_weapon_body_entered(body):
	if not is_network_master():
		return
	if can_deal_damage(body):
		var knockbak_direction = (global_position - body.global_position).normalized()
		var knockback_range = knockbak_direction * 10000
		body.rpc("hit", knockback_range * Vector2(-1, -1))

func can_deal_damage(body):
	return body.name != weapon_owner.name and animation_player.current_animation == "attacking"
