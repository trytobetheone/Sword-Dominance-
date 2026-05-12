extends Node

# 메인 게임 관리자
var score: int = 0
var game_over: bool = false
var game_time: float = 0.0
var max_game_time: float = 60.0  # 60초
var player: Node2D = null
var hud: Node = null

signal score_changed
signal time_changed
signal game_over_signal

func _ready() -> void:
	add_to_group("game_manager")
	player = get_tree().get_first_node_in_group("player")
	hud = get_tree().get_first_node_in_group("hud")

func _process(delta: float) -> void:
	if not game_over:
		game_time += delta
		emit_signal("time_changed", game_time)

		if game_time >= max_game_time:
			end_game()

		if player == null or not is_instance_valid(player):
			end_game()

func add_score(points: int) -> void:
	score += points
	emit_signal("score_changed", score)

func end_game() -> void:
	game_over = true
	print("게임 오버!")
	emit_signal("game_over_signal")
	# get_tree().paused = true  # 일단 비활성화
