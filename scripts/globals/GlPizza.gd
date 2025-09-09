extends Node

var pizzas = 0
var max_pizzas = 7
var is_at_max = false
var pizza_time_yield = 1.0
var is_game_ongoing = true
var is_blue_gift_mode = false
var is_in_last_30_seconds = false
var currency_this_round = 0
var currency_total = 0
var mythics_this_run = 0
var total_pizzas_collected = 0
var total_mythic_pizzas_collected = 0
var total_blue_gifts_collected = 0
var difficulty = "Normal"

# AI did this one - listing all the default values there because I've got more stuff to do
var _default_values := {
	"pizzas": 0,
	"max_pizzas": 7,
	"is_at_max": false,
	"pizza_time_yield": 1.0,
	"is_game_ongoing": true,
	"is_blue_gift_mode": false,
	"is_in_last_30_seconds": false,
	"currency_this_round": 0,
	"mythics_this_run": 0,
	"total_pizzas_collected": 0,
	"total_mythic_pizzas_collected": 0,
	"total_blue_gifts_collected": 0,
	"difficulty": "Normal"
}

func reset_state():
	for key in _default_values.keys():
		self.set(key, _default_values[key])

func add_pizza_count(type):
	print(pizzas)
	if pizzas >= max_pizzas:
		is_at_max = true
		return
	elif pizzas < max_pizzas:
		is_at_max = false
		if type == "mythic":
			mythics_this_run += 1
			total_mythic_pizzas_collected += 1
		pizzas += 1
		total_pizzas_collected += 1
		update_pizza_count()

func set_pizza_count(amount):
	pizzas = amount
	update_pizza_count()

func get_pizza_count():
	return pizzas

func reset_pizza_count():
	pizzas = 0
	update_pizza_count()

func update_pizza_count():
	emit_signal("pizza_count_changed", pizzas, max_pizzas)

func add_currency(amount):
	currency_this_round += amount
	currency_total += amount
	emit_signal("currency_count_changed", currency_this_round, max_pizzas)
	
func send_incoming_message(str, duration):
	emit_signal("incoming_message_update", str, duration)

func wait(duration):
	await get_tree().create_timer(duration).timeout

func set_game_finished():
	emit_signal("game_finished")

signal pizza_count_changed(count: int, max: int)
signal currency_count_changed(count: int, max: int)
signal incoming_message_update(message: String, duration: float)
signal game_finished()
