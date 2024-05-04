class_name Alien
extends Node2D

var speed: int = 50
var home: Accommodation = null
var workplace : Workstation = null
var isAtHome : bool = false
var isAtWork : bool = false
var hasBeenSendToWork : bool = false
var hasBeenSendToHome : bool = false

func SendToHome() -> void:
	hasBeenSendToWork = false
	hasBeenSendToHome = true

func SendToWork() -> void:
	hasBeenSendToWork = true
	hasBeenSendToHome = false

func _ready() -> void:
	hide()

func SetHome(accommodation: Accommodation) -> void:
	home = accommodation

func GetHome() -> Accommodation:
	return home

func SetWorkplace(_workplace: Workstation) -> void:
	workplace = _workplace

func GetWorkplace() -> Workstation:
	return workplace
