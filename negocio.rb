require "test/unit"

class Ocurrencia
  attr_reader :subtipo, :dia, :hora, :lugar, :descripcion, :reportante
  def initialize(subtipo, dia, hora, lugar, descripcion, reportante )
      @subtipo = subtipo
      @dia  = dia 
      @hora = hora
      @lugar = lugar
      @descripcion = descripcion
      @reportante = reportante
  end

  def tipoOcurrencia
  end

  def codigoImagen
  end
end


class SeguridadPublica < Ocurrencia
  def initialize(subtipo, dia, hora, lugar, descripcion, reportante )
    super(subtipo, dia, hora, lugar, descripcion, reportante)
  end

  def tipoOcurrencia
    return "Seguridad Publica"
  end

  def indiceGravedad
    case @subtipo
    when "Acoso Sexual"
      indice = 2
    when "Agresiones Fisicas"
      indice = 7
    when "Robo Agravado"
      indice = 6
    when "Pandillaje"
      indice = 4
    end
    return indice 
  end

  def codigoImagen
    return indiceGravedad.to_s + "_" + hora.to_s + "-#{subtipo}" + "_#{dia}"
  end

end

class SeguridadVial < Ocurrencia
  attr_accessor :aplicaMulta
  def initialize(subtipo, dia, hora, lugar, descripcion, reportante, aplicaMulta)
    super(subtipo, dia, hora, lugar, descripcion, reportante)
    @aplicaMulta = aplicaMulta
  end

  def tipoOcurrencia
    return "Seguridad Vial"
  end

  def indiceGravedad
    case @subtipo
    when "Atropello"
      indice = 10
    when "Vehiculos Mal Estacionados"
      indice = 5
    when "Choque"
      indice = 6
    when "Falta a las reglas transito"
      indice = 3
    end
    return indice 
  end

  def aplicarMulta
    if(@aplicaMulta == "Si")
      if indiceGravedad >= 10
        multa = 5000
      elsif indiceGravedad < 5
        multa = 400
      elsif indiceGravedad >= 6
        multa = 1800
      end
    end
    return multa
  end


  def codigoImagen
     return indiceGravedad.to_s + "_" + hora.to_s + "-#{subtipo}" + "_#{dia}" + "_#{aplicarMulta}"
  end
  
end

class ApoyoTurista < Ocurrencia
  def initialize(subtipo, dia, hora, lugar, descripcion, reportante)
    super(subtipo, dia, hora, lugar, descripcion, reportante)
  end

  def tipoOcurrencia
    return "Apoyo Turista"
  end

  def indiceGravedad
    case @subtipo
    when "Orientación"
      indice = 2
    when "Turista Incomunicado"
      indice = 5
    when "Apoyo Medico"
      indice = 6
    end
    return indice 
  end

  def codigoImagen
     return indiceGravedad.to_s + "_" + hora.to_s + "-#{subtipo}" + "_#{dia}-Turista" 
  end

end

class OrdenPublico < Ocurrencia
  def initialize(subtipo, dia, hora, lugar, descripcion, reportante)
    super(subtipo, dia, hora, lugar, descripcion, reportante)
  end

  def tipoOcurrencia
    return "Orden Público"
  end

  def indiceGravedad()
    case subtipo
    when "Discriminación"
      indice = 6
    when "Escandalo Publica"
      indice = 4
    when "Consumo de Licor"
      indice = 3
    when "Daño publico"
      indice = 5
    end
    return indice 
  end

  def codigoImagen
     return indiceGravedad.to_s + "_" + hora.to_s + "-#{subtipo}" + "_#{dia}"
  end

end

class Operador
  attr_accessor  :arrOcurrencias 
  def initialize
    @arrOcurrencias = Array.new
    @arrOperadores = ["Juan Jose", "Reportante 1", "Reportante 2", "Reportante 3"]
  end

  def registrarOcurrencia(ocurrencia)
         @arrOcurrencias.push(ocurrencia)
  end

  def validarOperador
      for operador in @arrOperadores
        if operador == "Juan Jose"
          return "si"
        end
        raise "No esta"
      end
  end


  def mostrarOcurrecias
     for ocurrencia in arrOcurrencias
         puts "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
         puts "SUB TIPO DE OCURRENCIA: #{ocurrencia.subtipo} | LUGAR: #{ocurrencia.lugar} | DESCRIPCIÓN: #{ocurrencia.descripcion} |  FECHA: #{ocurrencia.dia} | CÓDIGO DE IMAGEN: #{ocurrencia.codigoImagen} | REPORTANTE: #{ocurrencia.reportante}"
         
     end
  end

  def sumaMultas
    suma = 0
    for ocurrencia in arrOcurrencias
      if ocurrencia.tipoOcurrencia == "Seguridad Vial"
        suma = suma + ocurrencia.aplicarMulta
      end
    end
    return suma
  end


  def cantidadIncidencias
     cantidad = 0
     for ocurrencia in arrOcurrencias
        cantidad = cantidad + 1
     end
     return  cantidad
  end

  def buscarCantidadporTipo(tipo)
      cantidad = 0
      for ocurrencia in arrOcurrencias
        if ocurrencia.tipoOcurrencia == tipo
          cantidad = cantidad + 1
        end
      end
      return cantidad
  end

  def incidenciasporTipo(tipo)
      cantidad = 0
      for ocurrencia in arrOcurrencias
        if ocurrencia.tipoOcurrencia == tipo
          puts "------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
          puts "SUB TIPO DE OCURRENCIA: #{ocurrencia.subtipo} | LUGAR: #{ocurrencia.lugar} | DESCRIPCIÓN: #{ocurrencia.descripcion} |  FECHA: #{ocurrencia.dia} | CÓDIGO DE IMAGEN: #{ocurrencia.codigoImagen} | REPORTANTE: #{ocurrencia.reportante}"
        end
      end
  end

  def buscarOcurrenciasReportante(reportant)
       for ocurrencia in arrOcurrencias
          if ocurrencia.reportante == reportant
            return ocurrencia
          end
        end
        raise "<<<<<<<< REPORTANTE NO SE ENCUENTRA REGISTRADO >>>>>>>>>>"
  end

end


# class Supervisor 
#   attr_accessor :arrOperadores
#   def initialize
#     @arrOperadores = arrOperadores
#   end

#   def operadorRegsiter(operador)
#     arrOperadores.push(operador)
#   end

#   def listaOperadores
#     for operador in arrOperadores
#       puts operador.arrOperadores
#     end
#   end
# end


class Factoria                            
  def self.create(tipo, *arg)
     case tipo
     when "SeguridadPublica"
       return SeguridadPublica.new(arg[0], arg[1], arg[2], arg[3],arg[4], arg[5])
     when "OrdenPublico"
       return OrdenPublico.new(arg[0], arg[1], arg[2], arg[3],arg[4], arg[5])
     when "SeguridadVial"
       return SeguridadVial.new(arg[0], arg[1], arg[2], arg[3],arg[4],arg[5], arg[6])   
     when "ApoyoTurista"
       return ApoyoTurista.new(arg[0], arg[1], arg[2], arg[3],arg[4],arg[5] ) 
     end
  end
end
