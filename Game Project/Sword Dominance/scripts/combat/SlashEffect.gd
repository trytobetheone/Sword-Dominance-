extends Area2D

# 칼 휘두르는 이펙트 (히트박스 기반)
var duration: float = 0.2
var elapsed: float = 0.0
var hit_targets: Array = []  # 이미 맞힌 적 기록 (중복 공격 방지)

func _ready() -> void:
	# 히트박스 설정
	if has_node("CollisionShape2D"):
		var shape = RectangleShape2D.new()
		shape.size = Vector2(60, 40)  # 부채꼴 모양 근사
		$CollisionShape2D.shape = shape

	# 부채꼴 모양의 시각 이펙트 라인 생성 (5개)
	for i in range(5):
		var line = Line2D.new()
		line.add_point(Vector2.ZERO)
		line.add_point(Vector2(35, 0))
		line.width = 3
		line.default_color = Color(1, 1, 0.5, 0.8)  # 노란색 반투명
		line.rotation = (PI / 2) * (i / 4.0)  # 0도부터 90도까지 분산
		add_child(line)

	# 충돌 신호 연결
	area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	elapsed += delta

	# 회전 애니메이션 (위에서 아래로)
	rotation = -PI * (elapsed / duration)

	# 페이드아웃
	modulate.a = 1.0 - (elapsed / duration)

	if elapsed >= duration:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	# 적의 HitBox와 충돌 감지
	if area.name == "HitBox" and area.get_parent().is_in_group("enemy"):
		var enemy = area.get_parent()
		if enemy not in hit_targets:  # 중복 공격 방지
			hit_targets.append(enemy)
			enemy.take_damage(20)
			print("슬래시 히트! 적에게 20 대미지")
