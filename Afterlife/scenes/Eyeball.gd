extends Area2D

var active = false

func _ready():
	connect("body_entered", self, '_on_Eyeball_body_entered')
	connect("body_exited", self, '_on_Eyeball_body_exited')
	
func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("accept") and active:
			var canTalk = false
			get_tree().paused = true
			var dialog = Dialogic.start('Igor Intro')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
			
func unpause(timeline_name):
	get_tree().paused = false
	active = false
	

func _on_Eyeball_body_entered(body):
	if body.name == 'player':
		active = true
		
func _on_Eyeball_body_exited(body):
	if body.name == 'player':
		active = false

