
extends Node

const coin_node = preload("res://scenes/burrito.tscn")

const coins_to_create = [
		Vector2(500, -600),
		Vector2(600, -1500),
		Vector2(100, -2800),
		Vector2(400, -4000),
		Vector2(600, -6200),
		Vector2(1000, -7300),
		Vector2(800, -8500),
	]
		# add a bunch of places to create coins at
		
var coin_nodes = []

func _ready() -> void:
		for coin in coins_to_create:
			var coin_instance = coin_node.instantiate()
			coin_instance.position = coin
			add_child(coin_instance)
			coin_nodes.append(coin_instance)
		_connect_signals()
func _connect_signals():
	for coin in coin_nodes:
		coin.collected.connect(_coin_collected)

func _coin_collected(label_counting):
	$Player.increase_score(label_counting)
