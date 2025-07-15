extends Node

# ===================== CONSTANTES GLOBALES ===================
const PACMAN_INIT_POSITION = Vector2i(9, 8)

const FILAS = 15
const COLUMNAS = 19
const TILE_SIZE = [64, 64]

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
	"preparado": false,
	"en_juego": false,
	"transicion_vida_menos": false,
	"transicion_next_vida": false,
	"game_over": false
}

# LISTA DE FANTASMAS:
var fantasmas_instancias = []

# LISTA DESACTIVADOS:
var lista_desactivados = []

# LISTA_EXCEPCIONES (NO CREAR PUNTITOS EN ESAS POSICIONES):
var lista_excepciones = [
	PACMAN_INIT_POSITION, Vector2i(1, 1), Vector2i(17, 1), Vector2i(1, 12), Vector2i(17, 12)
]
