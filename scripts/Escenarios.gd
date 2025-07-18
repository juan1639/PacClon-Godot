extends Node

# ======================================================================
#	Nos provee de los laberintos/escenarios
#-----------------------------------------------------------------------

var laberinto = [
	[9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9],
	[9,5,1,1,1,1,1,1,1,9,1,1,1,1,1,1,1,5,9],
	[9,1,9,9,1,9,9,9,1,9,1,9,9,9,1,9,9,1,9],

	[9,1,9,9,1,9,9,9,1,9,1,9,9,9,1,9,9,1,9],
	[9,1,1,1,2,1,1,1,1,0,1,1,1,1,2,1,1,1,9],
	[9,1,9,9,1,9,1,9,9,9,9,9,1,9,1,9,9,1,9],

	[9,1,1,1,1,9,1,1,1,9,1,1,1,9,1,1,1,1,9],
	[9,9,9,9,1,9,9,9,1,9,1,9,9,9,1,9,9,9,9],
	[9,1,1,1,2,1,1,1,1,1,1,1,1,1,2,1,1,1,9],

	[9,1,9,9,1,9,1,9,9,9,9,9,1,9,1,9,9,1,9],
	[9,1,9,9,1,9,1,9,9,9,9,9,1,9,1,9,9,1,9],
	[0,1,1,1,1,9,1,1,1,0,1,1,1,9,1,1,1,1,0],

	[9,1,9,9,1,9,1,9,9,9,9,9,1,9,1,9,9,1,9],
	[9,5,1,1,2,1,1,1,1,0,1,1,1,1,2,1,1,5,9],
	[9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9],
]

func get_laberinto():
	if GlobalValues.marcadores["scene"] == 1:
		laberinto = [
			[9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9],
			[9,5,1,1,1,1,1,1,1,9,1,1,1,1,1,1,1,5,9],
			[9,1,9,9,1,9,9,9,1,9,1,9,9,9,1,9,9,1,9],

			[9,1,9,9,1,9,9,9,1,9,1,9,9,9,1,9,9,1,9],
			[9,1,1,1,2,1,1,1,1,0,1,1,1,1,2,1,1,1,9],
			[9,1,9,9,1,9,1,9,9,9,9,9,1,9,1,9,9,1,9],

			[9,1,1,1,1,9,1,1,1,9,1,1,1,9,1,1,1,1,9],
			[9,9,9,9,1,9,9,9,1,9,1,9,9,9,1,9,9,9,9],
			[9,1,1,1,2,1,1,1,1,1,1,1,1,1,2,1,1,1,9],

			[9,1,9,9,1,9,1,9,1,9,1,9,1,9,1,9,9,1,9],
			[9,1,9,9,1,9,1,9,1,9,1,9,1,9,1,9,9,1,9],
			[0,1,1,1,1,9,1,1,1,0,1,1,1,9,1,1,1,1,0],

			[9,1,9,9,1,9,1,9,9,9,9,9,1,9,1,9,9,1,9],
			[9,5,1,1,2,1,1,1,1,0,1,1,1,1,2,1,1,5,9],
			[9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9,9],
		]
	
	elif GlobalValues.marcadores["scene"] == 2:
		laberinto = [
			[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8],
			[8,5,1,1,1,1,1,1,1,8,1,1,1,1,1,1,1,5,8],
			[8,1,8,8,1,8,8,8,1,8,1,8,8,8,1,8,8,1,8],

			[8,1,8,8,1,8,8,8,1,7,1,8,8,8,1,8,8,1,8],
			[8,1,1,1,2,1,1,1,1,0,1,1,1,1,2,1,1,1,8],
			[8,1,3,4,1,6,1,3,8,8,8,4,1,6,1,3,4,1,8],

			[8,1,1,1,1,8,1,1,1,8,1,1,1,8,1,1,1,1,8],
			[8,8,8,4,1,8,8,4,1,7,1,3,8,8,1,3,8,8,8],
			[8,1,1,1,2,1,1,1,1,1,1,1,1,1,2,1,1,1,8],

			[8,1,8,8,1,6,1,6,1,6,1,6,1,6,1,8,8,1,8],
			[8,1,8,8,1,8,1,7,1,7,1,7,1,8,1,8,8,1,8],
			[0,1,1,1,1,8,1,1,1,0,1,1,1,8,1,1,1,1,0],

			[8,1,3,4,1,7,1,3,8,8,8,4,1,7,1,3,4,1,8],
			[8,5,1,1,2,1,1,1,1,0,1,1,1,1,2,1,1,5,8],
			[8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8],
		]
	
	return laberinto
