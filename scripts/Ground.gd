extends StaticBody2D

func _ground_touched(body: Node2D) -> void:
	if body.name.contains("Pizza"):
		get_tree().create_tween().tween_property(body.get_node("Sprite2D"), "modulate:a", 0, 0.25)
		await get_tree().create_timer(0.25).timeout
		body.queue_free()
