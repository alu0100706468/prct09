#require "matrix_disp/version"

module Math
  class Fraccion
        include Comparable
            #Accessors para poder acceder a los métodos :num y :denom
            attr_accessor :num 
            attr_accessor :denom
	    
	    def coerce(other)
	      [self, other]
	    end
            #método que llama al constructor del objeto de la clase
	    def initialize(n, d) 
                        @num = n
                        @denom = d
                        gcd #reduce la fracción
	    end
            #método que reduce la fracción calculando el mcd y dividiendolo entre el numerador y el denominador
	    def gcd
                          mcd, v = @num.abs, @denom.abs
                          while v > 0
                            mcd, v = v, mcd % v
                          end
                          @num = @num/mcd
                          @denom = @denom/mcd
	    end
            #método que muestra la fracción en la forma a/b
            def to_s
                        "#{@num}/#{@denom}"
                        #puts "#{@num}/#{@denom}"
                        #cadena = "#{@num}/#{@denom}" #se usa para que la función to_s devuelva lo que acaba de imprimir por pantalla
	    end
	    def to_f
	      @num.to_f/@denom.to_f
	    end
            #método que muestra la fracción en la forma a/b en flotante
	    def to_sf
                        "#{@num.to_f}/#{@denom.to_f}"
                        #puts "#{@num.to_f}/#{@denom.to_f}"
                        #cadena = "#{@num.to_f}/#{@denom.to_f}" #se usa para que la función to_s devuelva lo que acaba de imprimir por pantalla
	    end        
            #método que devuelve true si la fracción con la que se compara es igual a la actual
	    def ==(o)
                return @num == o.num && @denom  == o.denom if o.instance_of? Fraccion
                false
            end
            #método que calcula el valor absoluto de la fracción
            def abs
                    @denom = @denom.abs
                    @num = @num.abs
	    end
            #método que calcula el recíproco de la fracción.
	    def reciprocal
                        tmpNumerador = @num
                        @num = @denom
                        @denom = tmpNumerador
	    end
            #método que calcula el inverso de la fracción
	    def -@               
                        @num = -@num
	    end
            #método que devuelve la suma de la fracción actual con la que se pasa como parámetro
	    def +(other)
                                Fraccion.new((@num*other.denom)+(@denom*other.num), @denom*other.denom)
            end
            #método que devuelve la resta de la fracción actual con la que se pasa como parámetro
            def -(other)
                                Fraccion.new((@num*other.denom)-(@denom*other.num), @denom*other.denom)
            end
            #método que devuelve la multiplicación de la fracción actual con la que se pasa como parámetro
            def *(other)
                                Fraccion.new(@num*other.num, @denom*other.denom)
            end
            #método que devuelve la división de la fracción actual con la que se pasa como parámetro
            def /(other)
                        other.reciprocal
                        Fraccion.new(@num*other.num, @denom*other.denom)
            end
	    #método que devuelve el módulo  de la fracción actual con la que se pasa como parámetro
            def %(other)
                other.reciprocal
                a = Fraccion.new(@num*other.num, @denom*other.denom)
                a.num % a.denom
            end
	    def divReciprocal(other)
		other.reciprocal
		a = Fraccion.new(@num*other.num, @denom*other.denom)
		a.reciprocal
		a
	    end
	    def <=>(other)
		(@num.to_f/@denom.to_f) <=> (other.num.to_f/other.denom.to_f)
	    end
 end
end
