extends Node

var pizzas = 0
var max_pizzas = 7
var is_at_max = false

func add_pizza_count():
	print(pizzas)
	if pizzas >= max_pizzas:
		is_at_max = true
		return
	elif pizzas < max_pizzas:
		is_at_max = false
		pizzas += 1
		update_pizza_count()

func get_pizza_count():
	return pizzas

func update_pizza_count():
	emit_signal("pizza_count_changed", pizzas, 7)

signal pizza_count_changed(count: int, max: int)
