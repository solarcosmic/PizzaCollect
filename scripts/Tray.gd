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


func _tray_entered(body: Node2D) -> void:
	print(body.name)
	if body.name.contains("Pizza") and not GlPizza.is_at_max == true:
		GlPizza.add_pizza_count()
		body.queue_free()
