extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel/CookingMaybeRevV1Official.play()
	await $Panel/CookingMaybeRevV1Official.finished
	while true:
		$Panel/CookingMaybeRevV3Official.play()
		await $Panel/CookingMaybeRevV3Official.finished


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/ParallaxBackground.scroll_offset.y += 10.0 * delta


func _on_play_button_up() -> void:
	get_tree().create_tween().tween_property($Panel/PlayButton, "position", Vector2($Panel/PlayButton.position.x, 750), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property($Panel/SettingsButton, "position", Vector2(1580, $Panel/SettingsButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/ExitButton, "position", Vector2(1580, $Panel/ExitButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
	await GlPizza.wait(1.0)
	get_tree().change_scene_to_file("res://main.tscn")

func _on_settings_button_up() -> void:
	get_tree().create_tween().tween_property($Panel/SettingsButton, "position", Vector2($Panel/SettingsButton.position.x, 750), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property($Panel/PlayButton, "position", Vector2(1580, $Panel/PlayButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/ExitButton, "position", Vector2(1580, $Panel/ExitButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)

func _on_exit_button_up() -> void:
	get_tree().create_tween().tween_property($Panel/ExitButton, "position", Vector2($Panel/ExitButton.position.x, 750), 0.5).set_trans(Tween.TRANS_ELASTIC)
	get_tree().create_tween().tween_property($Panel/PlayButton, "position", Vector2(1580, $Panel/PlayButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
	get_tree().create_tween().tween_property($Panel/SettingsButton, "position", Vector2(1580, $Panel/SettingsButton.position.y), 0.25).set_trans(Tween.TRANS_SINE)
