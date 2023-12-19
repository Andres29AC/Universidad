#TODO Archivo de Compilacion
#TODO Creando un makefile para Bison
Bison: Comprobador.y
	bison -oparser.c Comprobador.y
	#TODO Compilar el archivo parser.c y generar el ejecutable
	gcc -o ejecutable parser.c 
	#TODO Ejecutar el ejecutable
	./ejecutable
	#TODO Limpiar los archivos generados
	rm parser.c ejecutable

