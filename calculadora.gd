extends Control

@onready var display_text: Label = get_node("background/display/Label")

var numero_1: String
var numero_2: String
var operador: String = ""

var indice_numero_atual: int = 0

func _ready():
	display_text.text = "0"
	
	for button in get_tree().get_nodes_in_group("button"):
		button.pressed.connect(quando_o_botao_for_pressionado.bind(button.name))


func quando_o_botao_for_pressionado(nome_botao: String):
	match nome_botao:
		"reset":
			reset(true)
			
		"=":
			var value_1: int = int(numero_1)
			var value_2: int = int(numero_2)
			var result: int = 0
			
			match operador:
				"+":
					result = value_1 + value_2
				"-":
					result = value_1 - value_2
				"*":
					result = value_1 * value_2
				"/":
					@warning_ignore("integer_division")
					result = value_1 / value_2
			
			display_text.text = str(result)
			reset()
			
		"soma":
			change_operator("+")
		
		"sub":
			change_operator("-")
			
		"mult":
			change_operator("*")
		
		"div":
			change_operator("/")
		
		_:
			if indice_numero_atual == 0:
				numero_1 += nome_botao
				
				if operador == "":
					display_text.text = numero_1
				
			if indice_numero_atual == 1:
				numero_2 += nome_botao
				
				display_text.text = numero_1 + " " + operador + " " +  numero_2
		

func change_operator(sig: String) -> void:
	if numero_1 == "" or operador != "":
				return 
				
	operador = sig 
	indice_numero_atual = 1
	display_text.text = numero_1 + " " + operador
	
func reset(is_reseting: bool = false) -> void:
	indice_numero_atual = 0
	numero_1 = ""
	numero_2 = ""
	operador = ""
	
	if is_reseting:
		display_text.text = "0"
	
