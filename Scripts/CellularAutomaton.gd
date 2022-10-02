extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var framesPerStep = 60
export var boundsX = 5
export var boundsY = 5
export var loopAround = true
export var rules = [Vector3(), Vector3(), Vector3(0,1,2), Vector3(2,2,2), Vector3(), Vector3(), Vector3(), Vector3(), Vector3()]

var frame = 0
var toUpdateList = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	randomizeGrid(0.55)
	#runConway()
	pass # Replace with function body.

func _input(event):
	if(event.is_action_pressed("ui_select")):
		_ready()

func getRandomTile(var chance):
	var rand = randf()
	rand -= floor(rand)
	return int(rand < chance)

func randomizeGrid(var chance):
	for y in range(-boundsY, boundsY):
		for x in range(-boundsX, boundsX):
			set_cell(x,y,getRandomTile(chance)*2)
	pass

func getCellBounded(var xPos, var yPos):
	var x = xPos
	var y = yPos
	if loopAround:
		x += boundsX*3
		x %= boundsX*2
		x -= boundsX
		
		y += boundsY*3
		y %= boundsY*2
		y -= boundsY
		return get_cell(x, y)
	else:
		if abs(x) > boundsX || abs(y) > boundsY:
			return 0
		else:
			return get_cell(x, y)
	
func getNumberOfNeighbors(var x, var y, var minTileID):
	var neighbors = 0
	#var debugString = "Neighbors of ({x},{y}):".format({"x":x,"y":y})
	#print(debugString)
	for yOffset in range(-1,2):
		for xOffset in range(-1,2):
			var cell = getCellBounded(x+xOffset,y+yOffset)
			if (cell >= minTileID) && ((yOffset != 0)||(xOffset != 0)):
				neighbors += 1
			#debugString = "| ({x},{y}): {cell}".format({"x":x+xOffset,"y":y+yOffset,"cell":cell})
			#print(debugString)
	return neighbors

func evaluateCellConway(var x, var y):
	var cell = Vector3(x, y, 0)
	var neighbors = getNumberOfNeighbors(x, y, 2)
	var state = get_cell(x, y)
	cell.z = rules[neighbors][state]
	if(state != cell.z):
		toUpdateList.append(cell)

func runConway():
	#print("=================================")
	for y in range(0, boundsY):
		for x in range(0, boundsX):
			evaluateCellConway(x, y)
	
	for cell in toUpdateList:
		set_cell(cell.x, cell.y, cell.z)
	
	toUpdateList.clear()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	frame += 1
	if (frame % framesPerStep) != 0: pass
	else:
		frame = 0
		runConway()
	pass
