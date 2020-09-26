require_relative  'negocio'


class Vista  
   def mostrarMensaje(resultado_1)
      resultado_1
   end
end

class Controlador 
   attr_accessor :vista, :administrador
   def initialize(vista, administrador)
     @vista = vista
     @administrador = administrador
   end
   
   def registra(tipo, *arg)
      ocurrencias = Factoria.create(tipo, *arg)
      resultado = administrador.registrarOcurrencia(ocurrencias)
    end

   def imprimeListaOcurrencias
    ocurrencias = administrador.mostrarOcurrecias
    vista.mostrarMensaje(ocurrencias)
   end

   def cantidadTipoOcurrencia(tipo)
   		ocurrencias = administrador.buscarCantidadporTipo(tipo)
    	vista.mostrarMensaje(ocurrencias)
   end

   def incidenciasTipoOcurrencia(tipo)
      ocurrencias = administrador.incidenciasporTipo(tipo)
      vista.mostrarMensaje(ocurrencias)
   end

   def cantidadOcurrencias
     ocurrencias = administrador.cantidadIncidencias
    vista.mostrarMensaje(ocurrencias)
   end
   def imprimirSumaMultas
    ocurrencias = administrador.sumaMultas
    vista.mostrarMensaje(ocurrencias)
   end

   def mostrarOcReportante(nombre)
     ocurrencias = administrador.buscarOcurrenciasReportante(nombre)
      vista.mostrarMensaje(ocurrencias)

   end
end

class TestDatosOcurrencias < Test::Unit::TestCase

  def setup
      
    @admin = Operador.new()
    @vista = Vista.new
    @controlador = Controlador.new(@vista, @admin)
    begin
        @controlador.registra("SeguridadPublica","Acoso", "20-08-20","16:00","La molina", "Robo agrabado", "Paolo Buendia")
    rescue Exception =>e
       puts e.message
    end
   
    @controlador.registra("SeguridadPublica","Robo Agrabado", "25-09-20","16:00","Surco", "Robo agrabado 2", "Jorge Benavidez")
    @controlador.registra("OrdenPublico","Escandalo Publica", "25-09-20","16:00","Surco", "Robo agrabado 2", "Ana Gabriela Torres")
    @controlador.registra("SeguridadVial","Atropello", "22-07-20", "10:12", "Chisica Bajo", "Atropello Grave ", "Isabel Ibañez", "Si")
    @controlador.registra("SeguridadVial","Choque", "15-08-20", "22:00", "ChOsica Bajo", "Carro blanco choque ", "Pablo Hidalgo","Si")
    @controlador.registra("OrdenPublico","Escandalo Publica", "25-09-20","16:00","Surco", "Robo agrabado 2", "Milagros Villanueva")
    @controlador.registra("ApoyoTurista","Turista Incomunicado", "22-07-20", "10:12", "Chosica Bajo", "Turista se encuentra perdido en la zona", "Juan Valdez", "Si")
    @controlador.registra("ApoyoTurista","Orientación", "15-08-20", "22:00", "Chisica", "Orientación al turista", "Julio Gonzales","Si")
  end

  def testDatosOcurrencias
        puts
        puts "| ------------  |   LISTA DE TODOS LOS REGISTROS DE LAS OCURRENCIAS  | ------------  |"
        puts
        @controlador.imprimeListaOcurrencias
        puts "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        puts
        puts "|----  CANTIDAD DE INCIDENCIAS -----|"
        puts
        puts "TOTAL: #{@controlador.cantidadOcurrencias}" 
        puts
        puts "|----  SUMA DE MULTAS POR SEGURIDAD VIAL -----|"
        puts
        puts "LA SUMA DE S/.  #{@controlador.imprimirSumaMultas}" 
        puts 

        puts "------- CANTIDAD POR TIPO DE OCURRENCIA -----"
        tipo1 = "Seguridad Vial"
        tipo2 = "Orden Público"
        puts

        puts "POR TIPO DE OCURRENCIA #{tipo1}"
        puts
        puts "N° DE INIDENCIAS: #{@controlador.cantidadTipoOcurrencia(tipo1)}"
        puts
        puts "POR TIPO DE OCURRENCIA #{tipo2}"
        puts
        puts "N° DE INIDENCIAS: #{@controlador.cantidadTipoOcurrencia(tipo2)}"
        puts

        puts "-------------------------------------"
        puts "BUSQUEDA POR TIPO"
        puts
        puts "TIPO #{tipo1}"
        puts
        @controlador.incidenciasTipoOcurrencia(tipo1)
        puts "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
        puts
        puts "TIPO #{tipo2}"
        puts
        @controlador.incidenciasTipoOcurrencia(tipo2)
        puts

        begin
            @controlador.mostrarOcReportante("reportante5")
            @controlador.mostrarOcReportante("reportante1")
        rescue Exception =>e
            puts e.message
        end

  end
end











