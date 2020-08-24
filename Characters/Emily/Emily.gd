extends StaticBody2D

export (String, FILE, "*.json") var dialogue_file : String
var started_dialogue := false
var player

func _ready():
	player = get_tree().root.get_node("World/Player")
	print(player)
	
	Dialogue.connect("dialogue_ended", self, "_on_dialogue_end")

func talk():
	if started_dialogue == false:
		Dialogue.start_dialogue(dialogue_file)
		started_dialogue = true

func _on_dialogue_end():
	started_dialogue = false
