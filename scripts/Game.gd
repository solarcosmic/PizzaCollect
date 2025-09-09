extends Node2D

const pizza = preload("res://assets/Pizza.tscn")
const mythic_pizza = preload("res://assets/MythicPizza.tscn")
const blue_gift = preload("res://assets/BlueGiftPizza.tscn")
const danger_pizza = preload("res://assets/DangerPizza.tscn")

@onready var blue_gift_timer : Timer = $Control/Panel/BlueGiftTimer

func _ready() -> void:
	$Control/Panel/Leaving.modulate.a = 0
	$Control/Panel/IncomingMessage.modulate.a = 0
	$Control/Panel/CurrencyTotal.text = "Total: " + str(GlPizza.currency_total)
	GlPizza.connect("currency_count_changed", _on_currency_count_change)
	GlPizza.connect("incoming_message_update", _on_incoming_message_update)
	do_difficulty_stuff()
	await _do_loop()

var hold_time = 0
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		$Control/Panel/Leaving.modulate.a = 1
		hold_time += delta
		if hold_time >= 2.0:
			GlPizza.reset_state()
			get_tree().change_scene_to_file("res://menu.tscn")
	else:
		hold_time = 0.0
		$Control/Panel/Leaving.modulate.a = 0

var mythic_pizza_spawn_threshold = 98 # 98

var danger_pizza_probability = 75
# a loop that determines what to spawn at what time
func _do_loop():
	if GlPizza.difficulty == "Hard": danger_pizza_probability = 50
	while true:
		if GlPizza.is_game_ongoing == true:
			var range = randi() % 880 + 300
			var mythic = randi() % 100
			var gift_rate = randi() % 100
			if mythic >= mythic_pizza_spawn_threshold:
				var cloned = mythic_pizza.instantiate()
				$Pizzas.add_child(cloned)
				cloned.position = Vector2(range, -10)
				if GlPizza.difficulty == "Hard": cloned.set_gravity_scale(2.0)
				cloned.name = "MythicPizza"
				cloned.add_collision_exception_with($Player)
			if (randi() % 100) >= danger_pizza_probability:
				var cloned = danger_pizza.instantiate()
				$Pizzas.add_child(cloned)
				cloned.position = Vector2((randi() % 880 + 300), -10)
				if GlPizza.difficulty == "Hard": cloned.set_gravity_scale(2.0)
				cloned.name = "DangerPizza"
				cloned.add_collision_exception_with($Player)
			var cloned = pizza.instantiate()
			$Pizzas.add_child(cloned)
			cloned.position = Vector2((randi() % 880 + 300), -10)
			if GlPizza.difficulty == "Hard": cloned.set_gravity_scale(2.0)
			cloned.name = "Pizza"
			cloned.add_collision_exception_with($Player)
		await GlPizza.wait(GlPizza.pizza_time_yield)


# detects when the base has been entered
func _base_entered(body: Node2D) -> void:
	if body.name == "Player":
		if GlPizza.pizzas >= GlPizza.max_pizzas:
			# converting currency to points
			# The base for the regular pizzas is +1.
			# For every Mythic Pizza, you get +4.
			var cur_total = GlPizza.pizzas + (GlPizza.mythics_this_run * 4) # add mythic pizza stuff
			GlPizza.add_currency(cur_total)
			var pluscurrency = $Extras/PlusCurrency.duplicate()
			pluscurrency.position = $Player.position + Vector2(0, -30)
			pluscurrency.text = "+" + str(cur_total)
			$Extras.add_child(pluscurrency)
			GlPizza.reset_pizza_count()
			GlPizza.mythics_this_run = 0
			$Control/Panel/BaseGet.play()
			$Base.texture = load("res://assets/red_gradient.png")
			get_tree().create_tween().tween_property(pluscurrency, "modulate:a", 0, 0.5)
			await GlPizza.wait(0.5)
			pluscurrency.queue_free()

# spawns blue gifts
func _on_blue_gift_timer_timeout() -> void:
	if GlPizza.is_in_last_30_seconds == true: return
	var cloned = blue_gift.instantiate()
	$Pizzas.add_child(cloned)
	cloned.position = Vector2((randi() % 880 + 300), -10)
	if GlPizza.difficulty == "Hard": cloned.set_gravity_scale(2.0)
	cloned.name = "BlueGiftPizza"
	cloned.add_collision_exception_with($Player)
	var wait_time = randi() % 30 + 17.5
	blue_gift_timer.wait_time = wait_time
	blue_gift_timer.start()

func _on_currency_count_change(count: int, max: int) -> void:
	$Control/Panel/Currency.text = str(GlPizza.currency_this_round)
	$Control/Panel/CurrencyTotal.text = "Total: " + str(GlPizza.currency_total)

func _on_incoming_message_update(message: String, duration: float) -> void:
	$Control/Panel/IncomingMessage.modulate.a = 1
	$Control/Panel/IncomingMessage.text = message
	await GlPizza.wait(duration)
	get_tree().create_tween().tween_property($Control/Panel/IncomingMessage, "modulate:a", 0, 0.5)
	

func _on_main_menu_button_up() -> void:
	GlPizza.reset_state()
	get_tree().change_scene_to_file("res://menu.tscn")

func _on_play_again_button_up() -> void:
	GlPizza.reset_state()
	get_tree().change_scene_to_file("res://main.tscn")

func do_difficulty_stuff() -> void:
	var difficulty = GlPizza.difficulty
	if difficulty == "Hard":
		GlPizza.pizza_time_yield = 0.25
