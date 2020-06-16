extends "res://entities/enemies/entity.gd"

#variaves para animationtree
onready var animation_tree = $AnimationTree
onready var playBack = animation_tree.get("parameters/playback");


func _ready():
	playBack.start("Spawn")
	hp = 2


func _physics_process(delta):
	var current_state = playBack.get_current_node()
	if current_state == "Idle":
		#código para perseguir jogador, atacar etc...
		playBack.travel("Idle")
		#Teste
		if Input.is_action_pressed("attack"):
			playBack.travel("Attack")
			damage(1)

func damage(damage):
	hp -= damage
	if hp<=0:
		playBack.travel("Death")
		
func death_finish():
	self.queue_free()
