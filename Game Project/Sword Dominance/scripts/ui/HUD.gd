extends CanvasLayer

# HUD 관리자
# 플레이어 정보 UI 표시

func _ready() -> void:
	pass

func update_health(current: int, max: int) -> void:
	print("생명력: %d/%d" % [current, max])

func update_score(score: int) -> void:
	print("점수: %d" % score)

func show_game_over() -> void:
	print("게임 오버!")

func show_stage_clear() -> void:
	print("스테이지 클리어!")
