extends Node

# Example: 
#		"showName": "Wood 1x1x3 Slope",
#		"path": "",
#		"mesh": "res://Meshes/1x1x3 Slope.obj",
#		"shape": "res://prebuilds/1x1x3_Slope_ColisionShape.tscn",
#		"material": "res://Materials/defaultStructualMaterial.tres",
#		"color": Color(150,90,60,255)/255,
#		"type": "shape",
#		"cost": 4,
#		"mass": 1.5,
#		"maxHP": 30,
#		"size": Vector3(0.6,0.2,0.2),
#		"flows": [right,up,back,forward],
#		"volume": 12
#		"flowsSecondary": [right,left,up,back,forward],



const BLOCK_SIZE := 0.2 # meters per block

var blocks:Array

const up = Vector3.UP
const down = Vector3.DOWN
const left = Vector3.LEFT
const right = Vector3.RIGHT
const forward = Vector3.FORWARD
const back = Vector3.BACK

func _ready() -> void:
	defaultblocklist()

func setb(id: int, data: Blockdata) -> void:
	blocks[id] = data

func getb(id: int) -> Blockdata:
	return blocks[id]

func defaultblocklist(): 
	blocks.insert(0,Blockdata.new(
		0,
		"Metal Block",
		"",
		"res://Meshes/DefaultBoxMesh.tres",
		"res://Materials/MultiMeshBlockTexture.tres",
		"", # shape
		Color(110,110,110,255)/255,
		"block",
		10,
		7,
		500,
		Vector3(0.2,0.2,0.2)
	))
	blocks.insert(1,Blockdata.new(
		1,
		"Alu Block",
		"",
		"res://Meshes/DefaultBoxMesh.tres",
		"res://Materials/MultiMeshBlockTexture.tres",
		"", # shape
		Color(200,200,200,255)/255,
		"block",
		25,
		3,
		200,
		Vector3(0.2,.2,0.2)
	))		
	blocks.insert(2,Blockdata.new(
		2,
		"Wood Block",
		"",
		"res://Meshes/DefaultBoxMesh.tres",
		"res://Materials/MultiMeshBlockTexture.tres",
		"", # shape
		Color(150,90,60,255)/255,
		"block",
		5,
		1,
		30,
		Vector3(0.2,.2,0.2)
	))
	blocks.insert(3,Blockdata.new(
		3,
		"Lead Block",
		"",
		"res://Meshes/DefaultBoxMesh.tres",
		"res://Materials/MultiMeshBlockTexture.tres",
		"res://prebuilds/1x1x1_Slope_ColisionShape.tscn", # shape
		Color(20,30,35,255)/255,
		"block",
		10,
		25,
		200,
		Vector3(0.2,.2,0.2)
	))
	blocks.insert(4,Blockdata.new(
		4,
		"Metal 1x1x1 Slope",
		"",
		"res://Meshes/1x1x1 Slope.tres",
		"res://prebuilds/1x1x1_Slope_ColisionShape.tscn", # shape
		"res://Materials/defaultStructualMaterial.tres",
		Color(110,110,110,255)/255,
		"shape",
		7,
		3.5,
		30,
		Vector3(0.2,0.2,0.2),
		0,#[right,up,back,forward], # directions in which flow is allowed
		4 # Volume Per block
	))
	blocks.insert(5,Blockdata.new(
		5,
		"Alu 1x1x1 Slope",
		"",
		"res://Meshes/1x1x1 Slope.tres",
		"res://prebuilds/1x1x1_Slope_ColisionShape.tscn",
		"res://Materials/defaultStructualMaterial.tres",
		Color(200,200,200,255)/255,
		"shape",
		20,
		1.5,
		100,
		Vector3(0.2,0.2,0.2),
		0,#[right,up,back,forward], # directions in which flow is allowed
		4 # Volume Per block
	))
	blocks.insert(6,Blockdata.new(
		6,
		"Wood 1x1x1 Slope",
		"",
		"res://Meshes/1x1x1 Slope.tres",
		"res://prebuilds/1x1x1_Slope_ColisionShape.tscn",
		"res://Materials/defaultStructualMaterial.tres",
		Color(150,90,60,255)/255,
		"shape",
		4,
		0.25,
		30,
		Vector3(0.2,0.2,0.2),
		0,#[right,up,back,forward], # directions in which flow is allowed
		4 # Volume Per block
	))
	blocks.insert(7,Blockdata.new(
		7,
		"Metal 1x1x2 Slope",
		"",
		"res://Meshes/1x1x2 Slope.obj",
		"res://prebuilds/1x1x2_Slope_ColisionShape.tscn",
		"res://Materials/defaultStructualMaterial.tres",
		Color(110,110,110,255)/255,
		"shape",
		13,
		7,
		500,
		Vector3(0.4,0.2,0.2),
		0,#[right,up,back,forward],
		8,
		0,#[right,left,up,back,forward]
	))
	blocks.insert(8,Blockdata.new(
		8,
		"Alu 1x1x2 Slope",
		"",
		"res://Meshes/1x1x2 Slope.obj",
		"res://prebuilds/1x1x2_Slope_ColisionShape.tscn",
		"res://Materials/defaultStructualMaterial.tres",
		Color(200,200,200,255)/255,
		"shape",
		35,
		3,
		200,
		Vector3(0.4,0.2,0.2),
		0,#[right,up,back,forward],
		8,
		0,#[right,left,up,back,forward]
	))
	blocks.insert(9,Blockdata.new(
		9,
		"Wood 1x1x2 Slope",
		"",
		"res://Meshes/1x1x2 Slope.obj",
		"res://prebuilds/1x1x2_Slope_ColisionShape.tscn",
		"res://Materials/defaultStructualMaterial.tres",
		Color(150,90,60,255)/255,
		"shape",
		7,
		1,
		30,
		Vector3(0.4,0.2,0.2),
		0,#[right,up,back,forward],
		8,
		0,#[right,left,up,back,forward]
	))
	blocks.insert(10,Blockdata.new(
		10,
		"Metal 1x1x3 Slope",
		"",
		"res://Meshes/1x1x3 Slope.obj",
		"res://prebuilds/1x1x3_Slope_ColisionShape.tscn",
		"res://Materials/defaultStructualMaterial.tres",
		Color(110,110,110,255)/255,
		"shape",
		7,
		10.5,
		30,
		Vector3(0.6,0.2,0.2),
		0,#[right,up,back,forward],
		12,
		0,#[right,left,up,back,forward]
	))
	blocks.insert(11,Blockdata.new(
		11,
		"Alu 1x1x3 Slope",
		"",
		"res://Meshes/1x1x3 Slope.obj",
		"res://prebuilds/1x1x3_Slope_ColisionShape.tscn",
		"res://Materials/defaultStructualMaterial.tres",
		Color(200,200,200,255)/255,
		"shape",
		20,
		7.5,
		100,
		Vector3(0.6,0.2,0.2),
		0,#[right,up,back,forward],
		12,
		0,#[right,left,up,back,forward]
	))
	blocks.insert(12,Blockdata.new(
		12,
		"Wood 1x1x3 Slope",
		"",
		"res://Meshes/1x1x3 Slope.obj",
		"res://prebuilds/1x1x3_Slope_ColisionShape.tscn",
		"res://Materials/defaultStructualMaterial.tres",
		Color(150,90,60,255)/255,
		"shape",
		4,
		1.5,
		30,
		Vector3(0.6,0.2,0.2),
		0,#[right,up,back,forward],
		12,
		0,#[right,left,up,back,forward],
	))
