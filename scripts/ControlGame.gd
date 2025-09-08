extends Control

func _ready() -> void:
	GlPizza.connect("pizza_count_changed", _on_pizza_count_change)

func _on_pizza_count_change(count: int, max: int):
	if count < max:
		$Panel/PizzaCount.text = str(count) + " / " + str(max) + " Pizzas"
	else:
		$Panel/PizzaCount.text = str(count) + " / " + str(max) + " Pizzas (MAX) | Go to base to clear out your tray!"
