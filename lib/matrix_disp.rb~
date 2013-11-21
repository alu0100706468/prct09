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
 
 class SparseVector 
  attr_reader :vector

  def initialize(h = {})
    @vector = Hash.new(0)
    @vector = @vector.merge!(h)
  end

  def [](i)
    @vector[i] 
  end
  
  def []=(i,v)
    @vector[i] = v
  end

  def to_s
    @vector.to_s
  end
  
  def keys
    @vector.keys
  end
  
  def +(other)
    resultado = SparseVector.new
    for i in other.vector.keys do
      resultado[i] = other[i]
    end
    for i in @vector.keys do
      resultado[i] = @vector[i] + other[i]
    end
    resultado
  end

def -(other)
    resultado = SparseVector.new
    for i in other.vector.keys do
      resultado[i] = other[i]
    end
    for i in @vector.keys do
      resultado[i] = @vector[i] - other[i]
    end
    resultado
  end
end

class SparseMatrix < Matriz

  attr_reader :matrix

  def initialize(h = {})
    @matrix = Hash.new({})
    for k in h.keys do 
      @matrix[k] = if h[k].is_a? SparseVector
                     h[k]
                   else 
                     @matrix[k] = SparseVector.new(h[k])
                   end
    end
  end

  def [](i)
    @matrix[i]
  end
  
  def []=(i,other)
    for y in other.keys do
      puts "---- other[#{y}] #{other[y]}"
      @matrix[i][y] = other[y]
      puts "---- matrix[#{i}][#{y}] #{@matrix[i][y]}"
    end
  end

  def imp
    for i in @matrix.keys do
      puts "#{i} ---- #{@matrix[i].to_s}" 
    end
  end
  
  def col(j)
    c = {}
    for r in @matrix.keys do
      c[r] = @matrix[r].vector[j] if @matrix[r].vector.keys.include? j
    end
    SparseVector.new c
  end
  
  def +(other)
    resultado = SparseMatrix.new
    for i in other.matrix.keys do
      resultado.matrix[i] = other[i]
    end
    for i in @matrix.keys do
      for j in @matrix[i].keys do
	if other.matrix[i][j] == nil
	  resultado.matrix[i] = @matrix[i]
	else
	  resultado.matrix[i][j] = @matrix[i][j]+other.matrix[i][j]
	end
      end
    end
    resultado
  end

def -(other)
    resultado = SparseMatrix.new
    for i in other.matrix.keys do
      resultado.matrix[i] = other[i]
    end
    for i in @matrix.keys do
      for j in @matrix[i].keys do
	if other.matrix[i][j] == nil
	  resultado.matrix[i] = @matrix[i]
	else
	  resultado.matrix[i][j] = @matrix[i][j]-other.matrix[i][j]
	end
      end
    end
    resultado
  end
  
  
  
  def traspuesta
    resultado = SparseMatrix.new
    for i in @matrix.keys do
      for j in @matrix[i].keys do
	tmp = SparseVector.new
	for x in @matrix.keys do
	  for y in @matrix[x].keys do
	    #puts "#{j} == #{y}"
	    if j == y
	      #puts "#{j} == #{y}, por tanto tmp[#{i}] = #{@matrix[x][y]}"
	      tmp[i] = @matrix[x][y]
	      #puts "TMP[#{i}] = #{tmp[i]}"
	    end
	  end
	end
	resultado.matrix[j] = tmp
	#puts "resultado.matrix[#{j}] = #{tmp}, Y QUEDA: #{resultado.matrix[j]}"
      end
    end
    resultado
  end
  
  def *(other)
    trasp = self.traspuesta
    resultado = SparseMatrix.new
    for i in trasp.matrix.keys do
      for j in trasp.matrix[i].keys do
	if other.matrix[i][j] != nil
	  
	end
      end
    end
  end
  
def max
  max = 0
  for i in @matrix.keys do
    for j in @matrix[i].keys do
      if @matrix[i][j].is_a? Fraccion
	tmp = Fraccion.new(max,1)
	if @matrix[i][j] > tmp
	  max = @matrix[i][j].to_f
	end
      else
	if @matrix[i][j] > max
	  max = @matrix[i][j]
	end
      end
    end
  end
  max
end

def min
  min = 999999999
  for i in @matrix.keys do
    for j in @matrix[i].keys do
      if @matrix[i][j].is_a? Fraccion
	tmp = Fraccion.new(min,1)
	if @matrix[i][j] < tmp
	  min = @matrix[i][j].to_f
	end
      else
	if @matrix[i][j] < min
	  min = @matrix[i][j]
	end
      end
    end
  end
  min
end
end
end
