extends CanvasLayer

# REFERENCIAS:
@onready var puntos = $PanelContainer/MarginContainer/HBoxContainer/Puntos
@onready var nivel = $PanelContainer/MarginContainer/HBoxContainer/Nivel
@onready var vidas = $PanelContainer/MarginContainer/HBoxContainer/HBoxContainer/Vidas

var signalConnect = false

func _ready():
	print("Instanciando marcadores")
	
	if FuncionesAuxiliaresPacman.has_signal("marcador_actualizado"):
		print("FuncionesTilesMario tiene señal marcador_actualizado")
		FuncionesAuxiliaresPacman.connect("marcador_actualizado", Callable(self, "_actualizar_puntos"))
	else:
		print("FuncionesTilesMario NO ENCONTRADA señal marcador_actualizado")
	
	#if FuncionesAuxiliaresPacman.has_signal("monedas_actualizadas"):
		##print("FuncionesTilesMario tiene señal monedas_actualizadas")
		#FuncionesAuxiliaresPacman.connect("monedas_actualizadas", Callable(self, "_actualizar_monedas"))
	
	if FuncionesAuxiliaresPacman.has_signal("scene_actualizada"):
		print("FuncionesTilesMario tiene señal scene_actualizada")
		FuncionesAuxiliaresPacman.connect("scene_actualizada", Callable(self, "_actualizar_nivel"))
	else:
		print("FuncionesTilesMario NO ENCONTRADA señal scene_actualizada")

# FUNCIONES ACTUALIZAR MARCADORES:
func _actualizar_puntos():
	puntos.text = "Puntos: " + str(GlobalValues.marcadores["score"])

func _actualizar_vidas():
	vidas.text = "  x " + str(GlobalValues.marcadores["lives"])

func _actualizar_nivel():
	nivel.text = "Nivel: " + str(GlobalValues.marcadores["scene"])
