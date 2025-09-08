extends Node2D

const pizza = preload("res://assets/Pizza.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await _do_loop()

func _do_loop():
	while true:
		var cloned = pizza.instantiate()
		$Pizzas.add_child(cloned)
		cloned.position = Vector2((randi() % 980 + 200), 0)
		cloned.name = "Pizza"
		await get_tree().create_timer(1.0).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
