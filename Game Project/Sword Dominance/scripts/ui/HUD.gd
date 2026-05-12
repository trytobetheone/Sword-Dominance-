extends CanvasLayer

var player: Node2D = null
var game_manager: Node = null

func _ready() -> void:
	add_to_group("hud")
	print("HUD 준비됨!")
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	game_manager = get_tree().get_first_node_in_group("game_manager")

	print("HUD 플레이어: ", player)
	print("HUD 게임매니저: ", game_manager)

	if game_manager:
		if game_manager.has_signal("score_changed"):
			game_manager.score_changed.connect(_on_score_changed)
		if game_manager.has_signal("time_changed"):
			game_manager.time_changed.connect(_on_time_changed)
		if game_manager.has_signal("game_over_signal"):
			game_manager.game_over_signal.connect(_on_game_over)

func _process(delta: float) -> void:
	if player and is_instance_valid(player):
		if has_node("VBoxContainer/HealthLabel"):
			$VBoxContainer/HealthLabel.text = "생명력: %d/%d" % [player.health, player.max_health]

func _on_score_changed(score: int) -> void:
	if has_node("VBoxContainer/ScoreLabel"):
		$VBoxContainer/ScoreLabel.text = "점수: %d" % score

func _on_time_changed(time: float) -> void:
	if has_node("VBoxContainer/TimeLabel"):
		var remaining = 60.0 - time
		$VBoxContainer/TimeLabel.text = "남은 시간: %.1f초" % max(0, remaining)

func _on_game_over() -> void:
	if has_node("VBoxContainer/GameOverLabel"):
		$VBoxContainer/GameOverLabel.show()
