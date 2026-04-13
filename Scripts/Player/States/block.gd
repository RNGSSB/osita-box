extends State

var idleLoop = 0

func Exit():
	idleLoop = 0
	owner.isBlocking = false
	owner.makerHerVisible = false

func Enter():
	if !owner.inBurnout:
		owner.animSys.animPlay("Block")
		owner.isBlocking = true
		owner.makerHerVisible = true
		owner.bufferDodgeHI = false
		idleLoop = 0
	else:
		owner.animSys.animPlay("BlockBurn")
		owner.bufferDodgeHI = false
		idleLoop = 0

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if owner.animSys.CURRANIM != "BlockBurn":
		if Gamemanager.checkInputHold("Up") and owner.isBlocking:
			pass
		
		if !Gamemanager.checkInputHold("Up") and owner.stateFrame > 10 and owner.isBlocking:
			idleLoop = 0
			owner.animSys.animPlay("BlockEnd")
			owner.isBlocking = false
		
		if !owner.isBlocking:
			if owner.animSys.onFrame(2):
				owner.makerHerVisible = false
			if owner.animSys.animEnd:
				Transitioned.emit(self, "wait")
	else:
		if Gamemanager.checkInputHold("Up") and owner.isBlocking:
			pass
		
		if !Gamemanager.checkInputHold("Up") and owner.stateFrame > 10:
			idleLoop = 0
			Transitioned.emit(self, "wait")
		
		if !owner.inBurnout:
			Transitioned.emit(self, "wait")
