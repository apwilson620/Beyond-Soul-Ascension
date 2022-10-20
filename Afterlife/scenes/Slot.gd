extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var default_tex = preload("res://assets/UI/InventoryBox2Small.png")
var empty_tex = preload("res://assets/UI/InventoryBox1Small.png")
var selected_tex = preload("res://assets/UI/InventoryBoxSelected.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null
var selected_style: StyleBoxTexture = null

var ItemClass = preload("res://scenes/Item.tscn")
var item = null
var slot_index
var slot_type

enum SlotType {
	HOTBAR = 0,
	INVENTORY,
}

# Called when the node enters the scene tree for the first time.
func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	selected_style.texture = selected_tex
	refresh_style()
#	if randi() % 2 == 0:
#		item = ItemClass.instance()
#		add_child(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent('UI')
	inventoryNode.add_child(item)
	item = null
	refresh_style()
	
func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent('UI')
	inventoryNode.remove_child(item)
	add_child(item)
	refresh_style()

func initialize_item(item_name, item_quantity):
	if item == null:
		item = ItemClass.instance()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
	refresh_style()

func refresh_style():
	if SlotType.HOTBAR == slot_type and PlayerInventory.active_item_slot == slot_index:
		set('custom_styles/panel', selected_style)
	elif item == null:
		set('custom_styles/panel', empty_style)
	else:
		set('custom_styles/panel', default_style)
		
func removeFromSlot():
	remove_child(item)
	#var inventoryNode = find_parent('UI')
	#inventoryNode.add_child(item)
	item = null
	refresh_style()
