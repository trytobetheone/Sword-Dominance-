extends Node

# 메인 게임 관리자
# 게임 상태, 점수, 게임오버 관리

var score: int = 0
var wave: int = 1
var game_over: bool = false

func _ready() -> void:
	pass

func add_score(points: int) -> void:
	score += points

func next_wave() -> void:
	wave += 1
	print("웨이브 %d!" % wave)

func end_game() -> void:
	game_over = true
	print("최종 점수: %d" % score)
