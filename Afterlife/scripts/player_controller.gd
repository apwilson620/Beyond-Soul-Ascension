extends KinematicBody2D

onready var animation_tree = $AnimationTree
onready var state_machine = animation_tree.get("parameters/playback")
var idle_direction = false

var speed : int = 400
var half_speed : int = 200
var fall_speed : int = 800
var jump_speed : int = -1500 #if you change this remember to change worm digestion fall speed at bottom of file, should be -1500
var gravity : int = 100
var velocity = Vector2()
var jump_num = 0
var can_dub_jump = false #remember to make false later

func get_input(delta):
	velocity.x = 0
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("slow"):
		velocity.x += speed
		state_machine.travel("MoveRight")
		idle_direction = false
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("slow"):
		velocity.x -= speed
		state_machine.travel("MoveLeft")
		idle_direction = true
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#if(is_on_floor()):
		#$Jump.playing = true
		velocity.y = jump_speed
		jump_num = 1
	if Input.is_action_just_pressed("jump") and not is_on_floor() and can_dub_jump:
		if jump_num == 1 or jump_num == 0:
			$DubJump.playing = true
			$JumpParticles.emitting = true
			velocity.y = jump_speed * .8
			jump_num = 2
	if Input.is_action_pressed("move_down"):
		if(is_on_floor()):
			drop()
	if Input.is_action_pressed("slow") and Input.is_action_pressed("move_right"):
		velocity.x += half_speed
		state_machine.travel("MoveRight")
		idle_direction = false
	if Input.is_action_pressed("slow") and Input.is_action_pressed("move_left"):
		velocity.x -= half_speed
		state_machine.travel("MoveLeft")
		idle_direction = true
	if idle_direction == false and not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		state_machine.travel("IdleRight")
	if idle_direction == true and not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		state_machine.travel("IdleLeft")
			
	# gravity
	velocity.y += gravity + delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if is_on_floor():
		jump_num = 0
	
	pass

#func _process(delta):
#	if Input.is_action_pressed("jump") and is_on_floor():
#		#if(is_on_floor()):
#			velocity.y = jump_speed
#			jump_num = 1
#	if Input.is_action_pressed("jump") and not is_on_floor():
#		if jump_num == 1 or jump_num == 0:
#			velocity.y = jump_speed
#			jump_num = 2

func _physics_process(delta):
		get_input(delta)
		
func _process(delta):
	var fps = Engine.get_frames_per_second()
	var lerp_interval = velocity / fps
	var lerp_position = global_transform.origin + lerp_interval
	
	if fps > 60:
		$Sprite.set_as_toplevel(true)
		$Sprite.global_transform.origin = $Sprite.global_transform.origin.linear_interpolate(lerp_position, 40 * delta)
	else:
		$Sprite.global_transform = global_transform
		$Sprite.set_as_toplevel(false)

func drop():
	position.y += 5

func _on_RoomDetector_area_entered(area):
	var collision_shape = area.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents*2
	
	var view_size = get_viewport_rect().size
	if size.y < view_size.y:
		size.y = view_size.y
		
	if size.x < view_size.x:
		size.x = view_size.x
	
	var cam = $Camera2D
	cam.limit_top = collision_shape.global_position.y - size.y/2
	cam.limit_left = collision_shape.global_position.x - size.x/2
	cam.limit_bottom = cam.limit_top + size.y
	cam.limit_right = cam.limit_left + size.x
	
	
	 # Replace with function body.

func _input(event):
	if event.is_action_pressed("Pickup"):
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)


func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://scenes/main_scene.tscn")


#func _on_DigestiveTract_body_entered(body):
	#if body.name.match("player"):
		#$DigestiveTract/StaticBody2D/CollisionShape2D.set_deferred
		


#func _on_DigestiveTract_body_exited(body):
	#if body.name.match("player"):
		#$DigestiveTract/Stomach.set


func _on_Wizard_dub_jump(boolean):
	can_dub_jump = boolean


func _on_FallZone1_body_entered(body):
	get_tree().change_scene("res://scenes/main_scene.tscn")
