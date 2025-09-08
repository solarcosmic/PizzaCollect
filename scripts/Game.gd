extends Node2D

const pizza = preload("res://assets/Pizza.tscn")

func _ready() -> void:
	await _do_loop()

func _do_loop():
	while true:
		var cloned = pizza.instantiate()
		$Pizzas.add_child(cloned)
		cloned.position = Vector2((randi() % 980 + 200), 0)
		cloned.name = "Pizza"
		cloned.add_collision_exception_with($CharacterBody2D)
		await get_tree().create_timer(1.0).timeout
