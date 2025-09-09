extends Sprite2D

@export var side_offset: Vector2 = Vector2(30, 0)
@export var idle_offset: Vector2 = Vector2(0, -20)
@export var smoothness: float = 15.0
@export var pizza_spacing: float = 10.0
@export var max_pizzas: int = 7

func _process(delta: float) -> void:
	var player = get_parent()
	if player and player is CharacterBody2D:
		var target_offset = idle_offset
		if player.velocity.x > 0:
			target_offset = side_offset
		elif player.velocity.x < 0:
			target_offset = Vector2(-side_offset.x, side_offset.y)
		position = position.lerp(target_offset, delta * smoothness)


var has_finished_blue_gift = true
func _tray_entered(body: Node2D) -> void:
	print(body.name)
	if body.name.contains("BlueGiftPizza"):
		if has_finished_blue_gift == true:
			has_finished_blue_gift = false
			GlPizza.is_blue_gift_mode = true
			$"../../Control/Panel/SfxPickupGift".play()
			GlPizza.total_blue_gifts_collected += 1
			var random = randi() % 100
			if random < 50:
				var original_yield = GlPizza.pizza_time_yield
				GlPizza.pizza_time_yield = 0.5
				GlPizza.send_incoming_message("Pizzas spawn at double the speed for 10 seconds!", 9)
				await GlPizza.wait(10)
				GlPizza.pizza_time_yield = original_yield
			elif random >= 50:
				GlPizza.max_pizzas += 5
				GlPizza.update_pizza_count()
				GlPizza.send_incoming_message("Your capacity has increased by 5!", 3.5)
			GlPizza.is_blue_gift_mode = false
			has_finished_blue_gift = true
	elif body.name.contains("MythicPizza") and GlPizza.pizzas < GlPizza.max_pizzas:
		GlPizza.add_pizza_count("mythic")
		var plusmythic = $"../../Extras/PlusMythic".duplicate()
		plusmythic.position = body.position + Vector2(0, -30)
		body.queue_free()
		$"../../Extras".add_child(plusmythic)
		$"../../Control/Panel/GetPizza".play()
		get_tree().create_tween().tween_property(plusmythic, "modulate:a", 0, 0.5)
		await GlPizza.wait(0.5)
		plusmythic.queue_free()
	elif body.name.contains("DangerPizza"):
		var minusdanger = $"../../Extras/MinusDanger".duplicate()
		minusdanger.position = body.position + Vector2(0, -30)
		body.queue_free()
		minusdanger.text = "-" + str(GlPizza.pizzas)
		GlPizza.set_pizza_count(0)
		$"../../Base".texture = load("res://assets/red_gradient.png")
		$"../../Extras".add_child(minusdanger)
		$"../../Control/Panel/GetPizza".play() # change
		get_tree().create_tween().tween_property(minusdanger, "modulate:a", 0, 0.5)
		await GlPizza.wait(0.5)
		minusdanger.queue_free()
	elif body.name.contains("Pizza") and GlPizza.pizzas < GlPizza.max_pizzas:
		GlPizza.add_pizza_count("normal")
		var plusone = $"../../Extras/PlusOne".duplicate()
		plusone.position = body.position + Vector2(0, -30)
		body.queue_free()
		$"../../Extras".add_child(plusone)
		$"../../Control/Panel/GetPizza".play()
		get_tree().create_tween().tween_property(plusone, "modulate:a", 0, 0.5)
		await GlPizza.wait(0.5)
		plusone.queue_free()
