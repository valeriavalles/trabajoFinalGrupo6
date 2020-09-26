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
        @controlador.registra("SeguridadPublica","Acoso Sexual", "20-08-20","16:00","La molina", "Robo agrabado", "reportante1")
    rescue Exception =>e
       puts e.message
    end
    @controlador.registra("SeguridadPublica","Robo Agravado", "25-09-20","16:00","Surco", "Robo agrabado 2", "reportante12")
    @controlador.registra("OrdenPublico","Escandalo Publica", "25-09-20","16:00","Surco", "Robo agrabado 2", "reportante2")
    @controlador.registra("SeguridadVial","Atropello", "22-07-20", "10:12", "Chisica Bajo", "Atropello Grave ", "reportante1", "Si")
    @controlador.registra("SeguridadVial","Choque", "15-08-20", "22:00", "Chisica Bajo", "Carro blanco choque  leve ", "reportante1","Si")
  end

  def testDatosOcurrencias
        @controlador.imprimeListaOcurrencias
        puts "---------------------------------------------------------"
        puts "#----  CANTIDAD DE INCIDENCIAS -----#"
        puts @controlador.cantidadOcurrencias
        puts "#----  SUMA DE MULTAS POR SEGURIDAD VIAL -----#"
        puts "La suma de S/.  #{@controlador.imprimirSumaMultas}" 
        puts "---------------------------------------------------------"
        puts "-------Cantidad por tipo de Ocurrencias -----"
        tipo1 = "Seguridad Vial"
        tipo2 = "Orden Público"
        puts
        puts "Por tipo de Ocurrencia #{tipo1}"
        puts @controlador.cantidadTipoOcurrencia(tipo1)
        puts "-------------------------------------"
        puts "Por tipo de Ocurrencia #{tipo2}"
        puts @controlador.cantidadTipoOcurrencia(tipo2)
        puts "-------------------------------------"
        puts "Incidencias por tipo"
        puts "Tipo #{tipo1}"
        @controlador.incidenciasTipoOcurrencia(tipo1)
        puts "-------------------------------------"
        puts "Tipo #{tipo2}"
        @controlador.incidenciasTipoOcurrencia(tipo2)

        begin
            @controlador.mostrarOcReportante("reportante5")
            @controlador.mostrarOcReportante("reportante1")
        rescue Exception =>e
            puts e.message
        end

  end
end











