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


func _on_Butt_body_entered(body):
	if body.name.match("player"):
		$Sprite/AnimationPlayer.play("Pooping")
		$Poop.emitting = true
		$Poop/fart.playing = true
		$Poop/poo.playing = true
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
		#$Poop.emitting = true


func _on_Butt_body_exited(body):
	t.set_wait_time(3)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$Poop.emitting = false
	$Poop/fart.playing = false
	$Poop/poo.playing = false
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
