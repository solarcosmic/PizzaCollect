extends StaticBody2D

func _ground_touched(body: Node2D) -> void:
	if body.name.contains("Pizza"):
		get_tree().create_tween().tween_property(body.get_node("Sprite2D"), "modulate:a", 0, 0.25)
		await GlPizza.wait(0.25)
		if is_instance_valid(body) and not body.is_queued_for_deletion():
			body.queue_free()
