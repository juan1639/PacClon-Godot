extends CanvasLayer

# REFERENCIAS:
@onready var puntos = $PanelContainer/MarginContainer/HBoxContainer/Puntos
@onready var nivel = $PanelContainer/MarginContainer/HBoxContainer/Nivel
@onready var vidas = $PanelContainer/MarginContainer/HBoxContainer/HBoxContainer/Vidas

var signalConnect = false

func _ready():
	print("Instanciando marcadores")
	
	if FuncionesAuxiliaresPacman.has_signal("marcador_actualizado"):
		print("FuncionesAuxiliaresPacman tiene señal marcador_actualizado")
		FuncionesAuxiliaresPacman.connect("marcador_actualizado", Callable(self, "_actualizar_puntos"))
	else:
		print("FuncionesAuxiliaresPacman NO ENCONTRADA señal marcador_actualizado")
	
	if FuncionesAuxiliaresPacman.has_signal("vidas_actualizadas"):
		print("FuncionesAuxiliaresPacman tiene señal vidas_actualizadas")
		FuncionesAuxiliaresPacman.connect("vidas_actualizadas", Callable(self, "_actualizar_vidas"))
	else:
		print("FuncionesAuxiliaresPacman NO ENCONTRADA señal vidas_actualizadas")
	
	if FuncionesAuxiliaresPacman.has_signal("scene_actualizada"):
		print("FuncionesAuxiliaresPacman tiene señal scene_actualizada")
		FuncionesAuxiliaresPacman.connect("scene_actualizada", Callable(self, "_actualizar_nivel"))
	else:
		print("FuncionesAuxiliaresPacman NO ENCONTRADA señal scene_actualizada")

# FUNCIONES ACTUALIZAR MARCADORES:
func _actualizar_puntos():
	puntos.text = "Puntos: " + str(GlobalValues.marcadores["score"])

func _actualizar_vidas():
	vidas.text = "  x " + str(GlobalValues.marcadores["lives"])

func _actualizar_nivel():
	nivel.text = "Nivel: " + str(GlobalValues.marcadores["scene"])
