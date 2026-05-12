extends Node2D

# 칼 휘두르는 이펙트 (부채꼴 모양)
var duration: float = 0.2
var elapsed: float = 0.0

func _ready() -> void:
	# 부채꼴 모양의 슬래시 라인 생성 (5개)
	for i in range(5):
		var line = Line2D.new()
		line.add_point(Vector2.ZERO)
		line.add_point(Vector2(35, 0))
		line.width = 3
		line.default_color = Color(1, 1, 0.5, 0.8)  # 노란색 반투명
		line.rotation = (PI / 2) * (i / 4.0)  # 0도부터 90도까지 분산
		add_child(line)

func _process(delta: float) -> void:
	elapsed += delta

	# 회전 애니메이션 (위에서 중단으로)
	rotation = -(PI / 2) * (elapsed / duration)

	# 페이드아웃
	modulate.a = 1.0 - (elapsed / duration)

	if elapsed >= duration:
		queue_free()
