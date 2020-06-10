extends Node2D

onready var starter_room = preload("res://rooms/starter_room.tscn")
onready var mid_room = preload("res://rooms/mid_room.tscn")
onready var top_room = preload("res://rooms/top_room.tscn")
onready var player = preload("res://entities/player/player.tscn").instance()

export var dungeon_levels = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_dungeon()

func generate_dungeon():
	var initial_room_pos = Vector2.ZERO
	var dungeons = fill_dungeon_rooms()
	print(dungeons)
	for dungeon in dungeons:
		dungeon.scene.position = initial_room_pos
		$'/root/game/world'.add_child(dungeon.scene)
		spawn_player_if_can(dungeon.spawn_player)
		initial_room_pos.y += 192

func fill_dungeon_rooms():
	var dungeons = []
	dungeons.resize(dungeon_levels)
	for i in range(dungeons.size()):
		dungeons[i] = { "scene": mid_room.instance(), "spawn_player": false }
	dungeons[0] = { "scene": starter_room.instance(), "spawn_player": true }
	dungeons[dungeons.size() - 1] = { "scene": top_room.instance(), "spawn_player": false }
	return dungeons
	

func spawn_player_if_can(spawn):
	if spawn:
		player.position = Vector2(100, 100)
		$'/root/game/world'.add_child(player)
