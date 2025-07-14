extends Node

# CONSTANTES GLOBALES:


# LIMITES MUNDO:


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
