extends Node

# CONSTANTES GLOBALES:
const PACMAN_INIT_POSITION = Vector2i(9, 4)

const FILAS = 15
const COLUMNAS = 19
const TILE_SIZE = [64, 64]

const TILE_SOLIDO = 9

# VARIABLES GLOBALES:
var mini_pausa = false
var SPEED_LIST = [2, 4, 8]
var SPEED_ELEGIDA = 1
var timerFrutaLoop: Timer

# ESCENARIOS:
var escenarios = [
	preload("res://scenes/escena_1.tscn"),
	preload("res://scenes/escena_1.tscn"),
	preload("res://scenes/escena_1.tscn")
]

# FANTASMAS GLOBAL VALUES:
var porcentaje_seguir_a_pacman = 65
var fantasmas_azules = false
var timer_fantasmas_azules: Node2D
var duracion_fantasmas_azules = [7.5, 7.5, 6.9, 6.1, 5.2, 4.5, 3.9, 3.1, 2.5]
var contador_bonus_come_fantasmas = 100

# LISTA DE FANTASMAS:
var fantasmas_instancias = []

# DICCIONARIO DIRECCIONES (FRUTA): [x, y]
var dic_direcciones = {
	"null": [0, 0, "null", "Default", "Default"],
	"up": [0, -1, "doizde", "Arriba", "OjosArriba"],
	"do": [0, 1, "upizde", "Abajo", "OjosAbajo"],
	"iz": [-1, 0, "updode", "Izquierda", "OjosIzquierda"],
	"de": [1, 0, "updoiz", "Derecha", "OjosDerecha"]
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
	"lives": 2
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

# LISTA_EXCEPCIONES (NO CREAR PUNTITOS EN ESAS POSICIONES):
var lista_excepciones = [
	PACMAN_INIT_POSITION, Vector2i(1, 1), Vector2i(17, 1), Vector2i(1, 13), Vector2i(17, 13)
]
