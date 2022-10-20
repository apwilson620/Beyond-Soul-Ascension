extends Area2D

var t = Timer.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DigestiveTract_body_entered(body):
	if body.name.match("player"):
		t.set_wait_time(2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		$StaticBody2D/CollisionShape2D2.set_deferred("disabled", true)
		$StaticBody2D/CollisionShape2D3.set_deferred("disabled", true)
		#$StaticBody2D/CollisionShape2D4.set_deferred("disabled", true)
		#$StaticBody2D/CollisionShape2D5.set_deferred("disabled", true)


func _on_DigestiveTract_body_exited(body):
	if body.name.match("player"):
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
		$StaticBody2D/CollisionShape2D2.set_deferred("disabled", false)
		$StaticBody2D/CollisionShape2D3.set_deferred("disabled", false)
		#$StaticBody2D/CollisionShape2D4.set_deferred("disabled", false)
		#$StaticBody2D/CollisionShape2D5.set_deferred("disabled", false)
