extends Area2D

onready var _animation_player = $Sprite/AnimationPlayer
var is_open = true
var is_closed = false
var t = Timer.new()

func _process(delta):
	if is_open:
		_animation_player.play("HeadThrob")
		is_closed = false

func _on_PitMonsterHead_body_entered(body):
	if body.name.match("player"):
		is_open = false
		_animation_player.play("HeadClose")
		$Mouth/CollisionShape2D.set_deferred("disabled", false)
		$Mouth/CollisionShape2D2.set_deferred("disabled", false)
		$Mouth/CollisionShape2D3.set_deferred("disabled", false)
		$Mouth/CollisionShape2D4.set_deferred("disabled", false)
		$Mouth/CollisionShape2D5.set_deferred("disabled", false)
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		is_closed = true


func _on_PitMonsterHead_body_exited(body):
	if body.name.match("player") and is_closed == true:
		_animation_player.play("HeadOpen")
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		is_open = true
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
		$Mouth/CollisionShape2D.set_deferred("disabled", true)
		$Mouth/CollisionShape2D2.set_deferred("disabled", true)
		$Mouth/CollisionShape2D3.set_deferred("disabled", true)
		$Mouth/CollisionShape2D4.set_deferred("disabled", true)
		$Mouth/CollisionShape2D5.set_deferred("disabled", true)
		is_closed = false
	elif body.name.match("player") and is_closed == false:
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		_animation_player.play("HeadOpen")
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		is_open = true
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
		$Mouth/CollisionShape2D.set_deferred("disabled", true)
		$Mouth/CollisionShape2D2.set_deferred("disabled", true)
		$Mouth/CollisionShape2D3.set_deferred("disabled", true)
		$Mouth/CollisionShape2D4.set_deferred("disabled", true)
		$Mouth/CollisionShape2D5.set_deferred("disabled", true)
		is_closed = false
