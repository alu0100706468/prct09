#require "matrix_disp/version"

module Math

class Matriz
  def initialize (f,c,v)
    @f, @c = f, c
    @v = v
  end
  
  def def_tipo
    if (((@v.count{|e| e == 0}*100)/(@f*@c)) >= 60)
      resultado = SparseMatrix.new
      for i in (0...@f*@c)
	tmp = SparseVector.new
	if @v[i] != 0
	  if resultado.matrix[i%@c].is_a? SparseVector
	    resultado.matrix[i%@c][i/@f] = @v[i]
	  else
	    tmp[i/@f] = @v[i]
	    resultado.matrix[i%@c] = tmp
	  end
	end
      end
      return resultado
    else
      return DenseMatrix.new(@f,@c,@v)
    end
  end
end
  
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


class DenseMatrix < Matriz
  attr_accessor :m
  attr_accessor :f
  attr_accessor :c

  def initialize(filas, columnas, v)
    @f = filas
    @c = columnas
    @m = []
    i = 0
    while i < @f*@c
      @m[i] = v[i]
      i=i+1
    end
  end

  def [](a,b)
    @m[a+(b*@c)]
  end

  def []=(a,b,r)
    @m[a+(b*@c)] = r
  end

  def *(other)
    a = Array.new(@f*@c, 0)
    resultado = DenseMatrix.new(@f, @c, a)
    if @f*@c == other.c*other.f
      for i in (0...@c) do
	for j in (0...@f) do
	  s = 0
	  for k in (0...@c) do 
	    s = s + (@m[i+(k*@c)] * other.m[k+(j*other.c)]) 
	  end
	  resultado[i,j] = s
	end
      end
    else
      puts "Las matriz A debe tener el mismo numero de filas que las columnas de B"
    end
    resultado
  end

  def +(other)
    i = 0
    tmp = []
    while i < @f*@c
      tmp[i] = @m[i]+other.m[i]
      i=i+1
    end
    tmp
end

  def -(other)
    i = 0
    tmp = []
    while i < @f*@c
      tmp[i] = @m[i]-other.m[i]
      i=i+1
    end
    tmp
end

                def det(*other)
                        resultado = 0
                        if other.size == 0
                                for i in (0...@c) do
                                                j = 0;
                                                adj = []
                                                z = 0
                                                for x in (0...@c) do
                                                        for y in (0...@f) do
                                                                if (x != i) && (y != j)
                                                                        adj[z] = @m[x+(y*@c)]
                                                                        z=z+1
                                                                end
                                                        end
                                                end
                                                if ((i+1)+(j+1))%2 == 0
                                                        resultado = resultado + @m[i+(j*@c)]*det(adj)
                                                else
                                                        resultado = resultado - @m[i+(j*@c)]*det(adj)
                                                end
                                end
                        else 
                                if other[0].size == 1
                                        tmp = other[0]
                                        return tmp[0]
                                else 
                                        if other[0].size >= 4
                                                for i in (0...Math.sqrt(other[0].size).to_i) do
                                                                j=0
                                                                adj = []
                                                                z = 0
                                                                for x in (0...Math.sqrt(other[0].size).to_i) do
                                                                        for y in (0...Math.sqrt(other[0].size).to_i) do
                                                                                if (x != i) && (y != j)
                                                                                        adj[z] = other[0][x+(y*Math.sqrt(other[0].size).to_i)]
                                                                                        z=z+1
                                                                                end
                                                                        end
                                                                end
                                                                if ((i+1)+(j+1))%2 == 0
                                                                        tmp = other[0]
                                                                        resultado = resultado + tmp[i+(j*Math.sqrt(other[0].size).to_i)]*det(adj)
                                                                else
                                                                        tmp = other[0]
                                                                        resultado = resultado - tmp[i+(j*Math.sqrt(other[0].size).to_i)]*det(adj)
                                                                end
                                                end
                                        end
                                end
                        end
                        return resultado
                end

                def adj()
                        a = Array.new(@f*@c, 0)
			resultado = DenseMatrix.new(@f, @c, a)
                        for i in (0...@c) do
                                for j in (0...@f) do
                                        adj = []
                                        z = 0
                                        for x in (0...@c) do
                                                for y in (0...@f) do
                                                        if (x != i) && (y != j)
                                                                adj[z] = @m[x+(y*@c)]
                                                                z=z+1
                                                        end
                                                end
                                        end
                                        if ((i+1)+(j+1))%2 == 0
                                                resultado[i,j] = det(adj)
                                        else
                                                resultado[i,j] = -det(adj)
                                        end
                                end
                        end
                        return resultado
                end

                def tras()
                        a = Array.new(@f*@c, 0)
			resultado = DenseMatrix.new(@f, @c, a)
                        for i in (0...@c) do
                                for j in (0...@f) do
                                        resultado[i,j] = @m[j+(i*@c)]
                                end
                        end
                        return resultado
                end

                def inv
                        determinante = self.det
                        if determinante != 0
                                a = Array.new(@f*@c, 0)
				resultado = DenseMatrix.new(@f, @c, a)
                                resultado = self.adj
                                resultado = resultado.tras
                                for i in (0...resultado.c) do
                                        for j in (0...resultado.f) do
                                                resultado[i,j] = (1/determinante.to_f)*resultado[i,j]
                                        end
                                end
                                return resultado
                        end
                end

                def imprimir
                        for i in (0...@c*@f) do
                                print "#{@m[i].round(2)}\t"
                                if i % @c == 2
                                        print "\n"
                                end
                        end
                end

                def /(other1)
                        a = Array.new(@f*@c, 0)
			resultado = DenseMatrix.new(@f, @c, a)
                        other = other1.inv
                if @f*@c == other.c*other.f
                    for i in (0...@c) do
                        for j in (0...@f) do
                                s = 0
                                for k in (0...@c) do 
				  s = s + (@m[i+(k*@c)] / other.m[k+(j*other.c)]) 
				end
                                resultado[i,j] = s
                        end
                    end
                else
                puts "Las matriz A debe tener el mismo numero de filas que las columnas de B"
                end
                resultado
                end
end

if __FILE__ == $0 
#   a = Fraccion.new(4,5)
#   z = SparseMatrix.new 1000 => { 100 => a, 500 => 200}, 20000 => { 1000 => 3, 9000 => 200}
#   y = SparseMatrix.new 1500 => { 100 => a, 500 => 20}, 20000 => { 1000 => 3, 9000 => 200}
#   z.imp
#   puts "z[1000] = #{z[1000]}"
#   puts "z[1000][200] = #{z[1000][200]}"
#   puts "z[4] = #{z[4]}"
#   puts "z[1000][500] = #{z[1000][500]}"
#   puts "z[0][0] = #{z[0][0]}"
#   
#   puts "-------------------------"
#   x = z.traspuesta
#   x.imp
#   puts "-------------------------"
#   
#    puts "-------------------------"
#    r = z - y
#    puts "-------------------------"
#    r.imp
#    puts "-------------------------"
#    b = SparseVector.new ({ 1 => 10, 2 => 22, 3 => 33 })
#    c = SparseVector.new ({ 1 => 10, 2 => 20, 3 => 30 })
#    x = b + c
#    
#    puts x
#   
#   mi = z.min
#   puts mi
  
  a = Matriz.new(3,3,[1,2,3,4,5,6,7,8,9])
  b = a.def_tipo
  puts b.class
  puts "-------------------"
  b.imprimir
  
  c = Matriz.new(3,3,[1,0,0,0,0,6,0,0,9])
  d = c.def_tipo
  puts d.class
  puts "-------------------"
  d.imp
  
  
end

end

