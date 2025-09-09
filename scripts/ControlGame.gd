extends Control

var is_playing_final_countdown_music = false

func _ready() -> void:
	GlPizza.connect("pizza_count_changed", _on_pizza_count_change)
	$Panel/Countdown.start()

func _on_pizza_count_change(count: int, max: int):
	if count < max:
		$Panel/PizzaCount.text = str(count) + " / " + str(max) + " Pizzas"
	else:
		$Panel/PizzaCount.text = "Go to base to clear out your tray!"
		$"../Base".texture = load("res://assets/green_gradient.png")

# followed from https://www.youtube.com/watch?v=ejRXpRlFa_Y because lazy
func time_left():
	var time_left = $Panel/Countdown.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

var is_victory_playing = false
func _process(delta):
	var time = time_left()
	$Panel/Count.text = "%02d:%02d" % time
	if time == [0.0, 30]:
		if is_playing_final_countdown_music: return
		is_playing_final_countdown_music = true
		GlPizza.is_in_last_30_seconds = true
		$Panel/SomethingUpdated.volume_db = -80.0
		$Panel/SomethingUpdated.play()
		get_tree().create_tween().tween_property($Panel/SomethingUpdated, "volume_db", -10, 2)
		get_tree().create_tween().tween_property(GlPizza, "pizza_time_yield", 0.1, 25)
	elif time == [0.0, 0]:
		if is_victory_playing == true: return
		is_victory_playing = true
		GlPizza.is_game_ongoing = false
		$Panel/PizzaCount.text = "Time's up!"
		$Panel/Victory.volume_db = 5
		$Panel/Victory.play()
