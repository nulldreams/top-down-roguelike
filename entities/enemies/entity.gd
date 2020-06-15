extends KinematicBody2D


var hp = 3



func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass


func damage(damage):
	hp -= damage
#	if hp<=0:
#		$AnimationPlayer.play("death")
#	else: 
#		$AnimationPlayer.play("hit")
