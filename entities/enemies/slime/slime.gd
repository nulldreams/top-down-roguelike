extends "res://entities/enemies/entity.gd"

#variaves para animationtree
onready var animation_tree = $AnimationTree
onready var playBack = animation_tree.get("parameters/playback");

func _ready():
	playBack.start("Idle")
	hp = 5

func _physics_process(delta):
	var current_state = playBack.get_current_node()
	if current_state != "Death":
		if current_state == "Idle":
			#código para perseguir jogador, atacar etc...
			playBack.travel("Idle")
			#Teste
			if Input.is_action_pressed("attack"):
				damage(1)

#func _process(delta):



func damage(damage):
	hp -= damage
	if hp<=0:
		playBack.travel("Death")
	else:
		playBack.travel("Hit")
