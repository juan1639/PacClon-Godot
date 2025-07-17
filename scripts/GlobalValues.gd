extends Node

# CONSTANTES GLOBALES:
const PACMAN_INIT_POSITION = Vector2i(9, 4)

const FILAS = 15
const COLUMNAS = 19
const TILE_SIZE = [64, 64]

const TILE_SOLIDO = 9

# FANTASMAS GLOBAL VALUES:
var porcentaje_seguir_a_pacman = 55

# DICCIONARIO DIRECCIONES (FRUTA): [x, y]
var dic_direcciones = {
	"null": [0, 0, "null", "Default"],
	"up": [0, -1, "doizde", "Arriba"],
	"do": [0, 1, "upizde", "Abajo"],
	"iz": [-1, 0, "updode", "Izquierda"],
	"de": [1, 0, "updoiz", "Derecha"]
}

# DICCIONARIO ID-FANTASMAS:
var dic_id_fantasmas = {
	"azul": ["", 3, 8],
	"rojo": ["rojo", 5, 8],
	"verde": ["verde", 14, 8],
	"rosa": ["rosa", 16, 8]
}

# PUNTOS INTERSECCIONES (OJO! MULTIPLOS DE 50, hay que convertirlos a MULTIPLOS de 64):
var lista_puntos_intersecciones = [
	[75, 425], [225, 225], [225, 425], [225, 675], [225, 575],
	[325, 575], [225, 75], [425, 425], [325, 225],
	[875, 425], [725, 225], [725, 425], [725, 675], [725, 575],
	[625, 575], [725, 75], [525, 425], [625, 225]
]

# LIMITES MUNDO (CAMARA):
const TOP_LIMIT = 0
const BOTTOM_LIMIT = 960
const LEFT_LIMIT = 0
const RIGHT_LIMIT = 1212

# REFERENCIAS GLOBALES:
var game_manager_node: Node2D = null
var ref_tilemap: TileMapLayer = null
var ref_oculta_tile: Sprite2D = null

# REFERENCIA GLOBAL A PACMAN:
var pacmanRG: CharacterBody2D = null

# MARCADORES:
var marcadores = {
	"score": 0,
	"scene": 1,
	"lives": 3
}

# ESTADOS DEL JUEGO
var estado_juego = {
	"prejuego": true,
	"transicion_preparado": false,
	"en_juego": false,
	"transicion_vida_menos": false,
	"transicion_next_vida": false,
	"transicion_level_up": false,
	"game_over": false
}

# Referencia al labarinto (de cada SCENE):
var laberinto = null

# LISTA DE FANTASMAS:
var fantasmas_instancias = []

# LISTA DESACTIVADOS:
var lista_desactivados = []

# LISTA_EXCEPCIONES (NO CREAR PUNTITOS EN ESAS POSICIONES):
var lista_excepciones = [
	PACMAN_INIT_POSITION, Vector2i(1, 1), Vector2i(17, 1), Vector2i(1, 13), Vector2i(17, 13)
]
