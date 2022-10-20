extends Area2D

var active = false
var has_pearl = false
var found_item = false
var completed_quest = false
var slot = null
signal dub_jump(boolean)
var rng = RandomNumberGenerator.new()
#var player = preload("res://scripts/player_controller.gd")

func _ready():
	connect("body_entered", self, '_on_Wizard_body_entered')
	connect("body_exited", self, '_on_Wizard_body_exited')
	
func _input(event):
	checkItem()
	if has_pearl and completed_quest == false:
		if get_node_or_null('DialogNode') == null:
			if event.is_action_pressed("accept") and active:
				PlayerInventory.delete_item(slot)
				#PlayerInventory.remove_item(slot)
				var canTalk = false
				get_tree().paused = true
				var dialog = Dialogic.start('AP QR')
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect('timeline_end', self, 'unpause')
				add_child(dialog)
				emit_signal("dub_jump", true)
				completed_quest = true
	elif completed_quest:
		rng.randomize()
		var num = rng.randi_range(1, 5)
		if num == 1:
			if get_node_or_null('DialogNode') == null:
				if event.is_action_pressed("accept") and active:
					var canTalk = false
					get_tree().paused = true
					var dialog = Dialogic.start('Wizard 1')
					dialog.pause_mode = Node.PAUSE_MODE_PROCESS
					dialog.connect('timeline_end', self, 'unpause')
					add_child(dialog)
		elif num == 2:
			if get_node_or_null('DialogNode') == null:
				if event.is_action_pressed("accept") and active:
					var canTalk = false
					get_tree().paused = true
					var dialog = Dialogic.start('Wizard 2')
					dialog.pause_mode = Node.PAUSE_MODE_PROCESS
					dialog.connect('timeline_end', self, 'unpause')
					add_child(dialog)
		elif num == 3:
			if get_node_or_null('DialogNode') == null:
				if event.is_action_pressed("accept") and active:
					var canTalk = false
					get_tree().paused = true
					var dialog = Dialogic.start('Wizard 3')
					dialog.pause_mode = Node.PAUSE_MODE_PROCESS
					dialog.connect('timeline_end', self, 'unpause')
					add_child(dialog)
		elif num == 4:
			if get_node_or_null('DialogNode') == null:
				if event.is_action_pressed("accept") and active:
					var canTalk = false
					get_tree().paused = true
					var dialog = Dialogic.start('Wizard 4')
					dialog.pause_mode = Node.PAUSE_MODE_PROCESS
					dialog.connect('timeline_end', self, 'unpause')
					add_child(dialog)
	else:
		if get_node_or_null('DialogNode') == null:
			if event.is_action_pressed("accept") and active:
				var canTalk = false
				get_tree().paused = true
				var dialog = Dialogic.start('Wizard Intro')
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				dialog.connect('timeline_end', self, 'unpause')
				add_child(dialog)
			
func unpause(timeline_name):
	get_tree().paused = false
	active = false
	
func checkItem():
	found_item = false
	for item in PlayerInventory.inventory:
		if PlayerInventory.inventory[item][0] == "Abyss Pearl" and found_item == false:
			has_pearl = true
			found_item = true
			var slot_index = item
			slot = get_tree().root.get_node("main/UI/Inventory/GridContainer/Panel" + str(slot_index + 1))
			#PlayerInventory.delete_item(slot)
			#Slot.remove_child(slot)
			#Slot.refresh_style()
			#return slot
			#PlayerInventory.inventory.erase(item)
			#PlayerInventory.update_slot_visual(item, "Abyss Pearl", 0)
		elif found_item == false:
			has_pearl = false
			

func _on_Wizard_body_entered(body):
	if body.name == 'player':
		active = true


func _on_Wizard_body_exited(body):
	if body.name == 'player':
		active = false
