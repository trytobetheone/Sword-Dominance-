extends Area2D

# 칼 휘두르는 이펙트 (위에서 아래로 내려오는 모션)
var duration: float = 0.2
var elapsed: float = 0.0
var hit_targets: Array = []  # 이미 맞힌 적 기록 (중복 공격 방지)
var start_y: float = 0.0

func _ready() -> void:
	# 히트박스 설정
	if has_node("CollisionShape2D"):
		var shape = RectangleShape2D.new()
		shape.size = Vector2(60, 40)  # 부채꼴 모양 근사
		$CollisionShape2D.shape = shape

	start_y = position.y

	# 부채꼴 모양의 시각 이펙트 라인 생성 (5개)
	# 처음부터 위쪽(상단)을 향하도록 배치
	for i in range(5):
		var line = Line2D.new()
		line.add_point(Vector2.ZERO)
		line.add_point(Vector2(35, 0))
		line.width = 3
		line.default_color = Color(1, 1, 0.5, 0.8)  # 노란색 반투명
		# 위쪽(PI/2)에서 시작해서 부채꼴 모양으로 분산
		line.rotation = (PI / 2) + (PI / 4) * (i / 4.0)
		add_child(line)

	# 충돌 신호 연결
	area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	elapsed += delta
	var progress = elapsed / duration  # 0 ~ 1

	# 위치: 위에서 아래로 내려옴 (-60 ~ +40)
	position.y = start_y - 60 + (100 * progress)

	# 회전: 위에서 아래로 휘둘러짐 (0도 ~ 180도)
	rotation = -PI * progress

	# 페이드아웃
	modulate.a = 1.0 - progress

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
