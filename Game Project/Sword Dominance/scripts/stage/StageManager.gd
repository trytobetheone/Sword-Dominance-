extends Node

# 스테이지 관리자
# 적 스폰, 스테이지 진행 관리

var current_stage: int = 1
var enemies_defeated: int = 0
var stage_complete: bool = false

func _ready() -> void:
	pass

func spawn_enemy(enemy_type: String, position: Vector2) -> void:
	print("적 스폰: %s at %s" % [enemy_type, position])

func check_stage_complete() -> bool:
	return stage_complete

func advance_stage() -> void:
	current_stage += 1
	print("스테이지 %d로 진행!" % current_stage)
