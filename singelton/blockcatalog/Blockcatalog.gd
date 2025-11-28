extends Node

# Example: 
#	_id: int = -1,
#	_showName: String = "",
#	_path: String = "",
#	_mesh: String = "",
#	_shape: String = "",
#	_material: String = "",
#	_colormat: Color = Color(1, 1, 1),
#	_type: String = "block",
#	_cost: float = 0.0,
#	_mass: float = 1.0,
#	_hpmax: int = 100,
#	_size: Vector3i = Vector3i(1, 1, 1),
#	_flows: int = 0b000100, # only 8 bits!
#	_volume: float = 0.0,
#	_flowssec: int = 0 # only 8 bits!



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
	if blocks.size() > id:
		return blocks[id]
	else:
		print("ERROR - block was requested of block that dosent exist!")
		return null

func size() -> int:
	return blocks.size()

func defaultblocklist(): 
	blocks.insert(0,Blockdata.new(
		0,
		"Metal Block",
		"",
		"res://Meshes/DefaultBoxMesh.tres",
		"res://prebuilds/defaultColisionShape.tres",
		"res://Materials/MultiMeshBlockTexture.tres",
		Color(110,110,110,255)/255,
		"block",
		10.0,
		20,#mass 30?
		500
	))
	blocks.insert(1,Blockdata.new(
		1,
		"Metal 1x1x1 Slope",
		"",
		"res://Meshes/1x1x1 Slope.tres",
		"res://prebuilds/1x1x1_Slope_ColisionShape.tres",
		"res://Materials/defaultStructualMaterial.tres",
		Color(110,110,110,255)/255,
		"shape",
		7,
		3.5,
		30,
		Vector3i.ONE,
		0,#[right,up,back,forward], # directions in which flow is allowed
		4 # Volume Per block
	))
	blocks.insert(2,Blockdata.new(
		2,
		"Metal 1x1x2 Slope",
		"",
		"res://Meshes/1x1x2 Slope.obj",
		"res://prebuilds/1x1x2_Slope_ColisionShape.tres",
		"res://Materials/defaultStructualMaterial.tres",
		Color(110,110,110,255)/255,
		"shape",
		13,
		7,
		500,
		Vector3(2,1,1),
		0,#[right,up,back,forward],
		8,
		0,#[right,left,up,back,forward]
	))
	blocks.insert(3,Blockdata.new(
		3,
		"Metal 1x1x3 Slope",
		"",
		"res://Meshes/1x1x3 Slope.obj",
		"res://prebuilds/1x1x3_Slope_ColisionShape.tres",
		"res://Materials/defaultStructualMaterial.tres",
		Color(110,110,110,255)/255,
		"shape",
		7,
		10.5,
		30,
		Vector3(3,1,1),
		0,#[right,up,back,forward],
		12,
		0,#[right,left,up,back,forward]
	))
	blocks.insert(4,Blockdata.new(
		4,
		"Metal 1x1x4 Slope",
		"",
		"res://Meshes/1x1x4 Slope.obj",
		"res://prebuilds/1x1x4_Slope_ColisionShape.tres",
		"res://Materials/defaultStructualMaterial.tres",
		Color(110,110,110,255)/255,
		"shape",
		7,
		10.5,
		30,
		Vector3(4,1,1),
		0,#[right,up,back,forward],
		12,
		0,#[right,left,up,back,forward]
	))
	blocks.insert(5,Blockdata.new(
		5,
		"Metal 1x1x6 Slope",
		"",
		"res://Meshes/1x1x6 Slope.obj",
		"res://prebuilds/1x1x6_Slope_ColisionShape.tres",
		"res://Materials/defaultStructualMaterial.tres",
		Color(110,110,110,255)/255,
		"shape",
		7,
		10.5,
		30,
		Vector3(6,1,1),
		0,#[right,up,back,forward],
		12,
		0,#[right,left,up,back,forward]
	))
	blocks.insert(6,Blockdata.new(
		6,
		"Metal 1x1x8 Slope",
		"",
		"res://Meshes/1x1x8 Slope.obj",
		"res://prebuilds/1x1x8_Slope_ColisionShape.tres",
		"res://Materials/defaultStructualMaterial.tres",
		Color(110,110,110,255)/255,
		"shape",
		7,
		10.5,
		30,
		Vector3(8,1,1),
		0,#[right,up,back,forward],
		12,
		0,#[right,left,up,back,forward]
	))
