extends Area2D

var active = false
var rng = RandomNumberGenerator.new()

func _ready():
	connect("body_entered", self, '_on_IBA_body_entered')
	connect("body_exited", self, '_on_IBA_body_exited')
	
func _input(event):
	rng.randomize()
	var num = rng.randi_range(0, 5)
	if num == 0:
		if get_node_or_null('DialogNode') == null:
			if event.is_action_pressed("accept") and active:
				var canTalk = false
				get_tree().paused = true
				var dialog = Dialogic.start('IBA 0')
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect('timeline_end', self, 'unpause')
				add_child(dialog)
	elif num == 1:
		if get_node_or_null('DialogNode') == null:
			if event.is_action_pressed("accept") and active:
				var canTalk = false
				get_tree().paused = true
				var dialog = Dialogic.start('IBA 1')
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect('timeline_end', self, 'unpause')
				add_child(dialog)
	elif num == 2:
		if get_node_or_null('DialogNode') == null:
			if event.is_action_pressed("accept") and active:
				var canTalk = false
				get_tree().paused = true
				var dialog = Dialogic.start('IBA 2')
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect('timeline_end', self, 'unpause')
				add_child(dialog)
	elif num == 3:
		if get_node_or_null('DialogNode') == null:
			if event.is_action_pressed("accept") and active:
				var canTalk = false
				get_tree().paused = true
				var dialog = Dialogic.start('IBA 3')
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect('timeline_end', self, 'unpause')
				add_child(dialog)
	elif num == 4:
		if get_node_or_null('DialogNode') == null:
			if event.is_action_pressed("accept") and active:
				var canTalk = false
				get_tree().paused = true
				var dialog = Dialogic.start('IBA 4')
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect('timeline_end', self, 'unpause')
				add_child(dialog)
	else:
		if get_node_or_null('DialogNode') == null:
			if event.is_action_pressed("accept") and active:
				var canTalk = false
				get_tree().paused = true
				var dialog = Dialogic.start('IBA 5')
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect('timeline_end', self, 'unpause')
				add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false
	active = false
	
	


func _on_IBA_body_entered(body):
	if body.name == 'player':
		active = true


func _on_IBA_body_exited(body):
	if body.name == 'player':
		active = false
