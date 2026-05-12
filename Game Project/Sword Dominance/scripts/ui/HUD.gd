extends CanvasLayer

var player: Node2D = null
var game_manager: Node = null

func _ready() -> void:
	add_to_group("hud")
	await get_tree().process_frame
	player = get_tree().first_child_in_group("player")
	game_manager = get_tree().root.get_child(0).get_node("GameManager")

	if game_manager:
		if not game_manager.score_changed.is_connected(_on_score_changed):
			game_manager.score_changed.connect(_on_score_changed)
		if not game_manager.time_changed.is_connected(_on_time_changed):
			game_manager.time_changed.connect(_on_time_changed)
		if not game_manager.game_over_signal.is_connected(_on_game_over):
			game_manager.game_over_signal.connect(_on_game_over)

func _process(delta: float) -> void:
	if player and is_instance_valid(player):
		$VBoxContainer/HealthLabel.text = "생명력: %d/%d" % [player.health, player.max_health]

func _on_score_changed(score: int) -> void:
	$VBoxContainer/ScoreLabel.text = "점수: %d" % score

func _on_time_changed(time: float) -> void:
	var remaining = 60.0 - time
	$VBoxContainer/TimeLabel.text = "남은 시간: %.1f초" % max(0, remaining)

func _on_game_over() -> void:
	$VBoxContainer/GameOverLabel.show()
