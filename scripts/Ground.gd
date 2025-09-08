extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _ground_touched(body: Node2D) -> void:
	if body.name.contains("Pizza"):
		get_tree().create_tween().tween_property(body.get_node("Sprite2D"), "modulate:a", 0, 0.25)
		await get_tree().create_timer(0.25).timeout
		body.queue_free()
