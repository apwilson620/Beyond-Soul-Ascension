extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const SlotClass = preload("res://scenes/Slot.gd")
onready var inventory_slots = $GridContainer
#var holding_item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i
		slots[i].slot_type = SlotClass.SlotType.INVENTORY
	initialize_inventory()
		
func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
		
func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if find_parent("UI").holding_item != null:
				if !slot.item:
					left_click_empty_slot(slot)
					
				else:
					if find_parent("UI").holding_item.item_name!= slot.item.item_name:
						left_click_different_item(event, slot)
					else:
						left_click_same_item(slot)
			elif slot.item:
				left_click_not_holding(slot)
				

func _input(event):
	if find_parent("UI").holding_item:
		find_parent("UI").holding_item.global_position = get_global_mouse_position()

func left_click_empty_slot(slot: SlotClass):
	PlayerInventory.add_item_to_empty_slot(find_parent("UI").holding_item, slot)
	slot.putIntoSlot(find_parent("UI").holding_item)
	find_parent("UI").holding_item = null

func left_click_different_item(event: InputEvent, slot: SlotClass):
	PlayerInventory.remove_item(slot)
	PlayerInventory.add_item_to_empty_slot(find_parent("UI").holding_item, slot)
	var temp_item = slot.item
	slot.pickFromSlot()
	temp_item.global_position = event.global_position
	slot.putIntoSlot(find_parent("UI").holding_item)
	find_parent("UI").holding_item = temp_item

func left_click_same_item(slot: SlotClass):
	var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
	var able_to_add = stack_size - slot.item.item_quantity
	if able_to_add >= find_parent("UI").holding_item.item_quantity:
		PlayerInventory.add_item_quantity(slot, find_parent("UI").holding_item.item_quantity)
		slot.item.add_item_quantity(find_parent("UI").holding_item.item_quantity)
		find_parent("UI").holding_item.queue_free()
		find_parent("UI").holding_item = null
	else:
		PlayerInventory.add_item_quantity(slot, able_to_add)
		slot.item.add_item_quantity(able_to_add)
		find_parent("UI").holding_item.decrease_item_quantity(able_to_add)
		
func left_click_not_holding(slot: SlotClass):
	PlayerInventory.remove_item(slot)
	find_parent("UI").holding_item = slot.item
	slot.pickFromSlot()
	find_parent("UI").holding_item.global_position = get_global_mouse_position()
	
#func delete_item(slot: SlotClass):
	#PlayerInventory.remove_item(slot)
	#slot.pickFromSlot
