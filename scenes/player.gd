extends CharacterBody2D

const SPEED = 900
const JUMP_VELOCITY = -1100
const GRAVITY = 800

const scorescene = preload("res://scenes/tracker.tscn")
		# load our little score label node - "const" because we don't need to change this value

	# also preload the images you want to use as icons here:
const icon1 = preload("res://assets/burrito_sprite.png")	# just usin the default godot icon here :sob:
					
var scores = [
		["coins", "5", icon1, Vector2(0, 100)],
		["bushes", "0", icon1, Vector2(0, 150)],
		["wood", "20", icon1, Vector2(0, 200)]
	]
		# ok so this is where we put all the scores we want to track, along with the score we want them
		# to start at, the image we want them to have, and the coordinates we want to put them at.
		# make sure you give each label a different position!! unless you really want them to overlap?
		# you can have them along the top, under the player (like i have them), one in each corner,
		# or even randomly scattered if you want that to make your game extra unique!!

var score_labels = []
		# this is where we'll be putting all of our instantiated score nodes,
		# just to save them for when we need to refer to them
		# (for example to check if we have enough of a certain item)

func _ready() -> void:
		for score in scores:
			var score_label = scorescene.instantiate()
					
			score_label.whatitscounting = score[0]
			score_label.val = int(score[1]) # the starting value of the item
			score_label.text = score[1] # this is the actual text displayed
			score_label.get_node("TextureRect").texture = score[2]
			score_label.position = score[3]
						
			# now, let's add it as a child and chuck it in the score_labels storage list:
			add_child(score_label)
			score_labels.append(score_label)

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Left/right movement (optional but useful)
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = 0

	move_and_slide()
