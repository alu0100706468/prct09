#require "matrix_disp/version"

module Math
  #Clase encargada de definir una matriz según el número de ceros.
  class Matriz
    #recoge el número de filas, número de columnas y un vector con los valores de la matriz.
    def initialize (f,c,v)
      @f, @c = f, c
      @v = v
    end
    #define el tipo de matriz y crea un objeto de matriz dispersa o de matriz densa según el número de ceros.
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
  #Clase que permite representar un número fraccionario y hacer las operaciones básicas.
  class Fraccion
    include Comparable
    
    attr_accessor :num 
    attr_accessor :denom
  	#método para permitir las operaciones desde otros tipos de datos con Fraccion
    def coerce(other)
      [self, other]
  	end
    #método que llama al constructor del objeto de la clase
    def initialize(n, d) 
      @num = n
      @denom = d
      gcd
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
    end
    def to_f
      @num.to_f/@denom.to_f
    end
    #método que muestra la fracción en la forma a/b en flotante
    def to_sf
      "#{@num.to_f}/#{@denom.to_f}"
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
    #método que calcula el recíproco de una fracción
  	def divReciprocal(other)
  		other.reciprocal
  		a = Fraccion.new(@num*other.num, @denom*other.denom)
  		a.reciprocal
  		a
    end
    #método de la guerra de las galaxias que permite los tipos de comparación ==, <, >, <=, >=
    def <=>(other)
  		(@num.to_f/@denom.to_f) <=> (other.num.to_f/other.denom.to_f)
    end
  end
  #Clase que permite representar un vector disperso
  class SparseVector 
    attr_reader :vector

    def initialize(h = {})
      @vector = Hash.new(0)
      @vector = @vector.merge!(h)
    end
    #método que permite la indexación de elementos del vector disperso
    def [](i)
      @vector[i] 
    end
    #método que permite la asignación de elementos del vector disperso
    def []=(i,v)
      @vector[i] = v
    end
    #método que permite pasar el vector a string
    def to_s
      @vector.to_s
    end
    #devuelve las claves del Hash @vector
    def keys
      @vector.keys
    end
    #método que implementa la suma de vectores dispersos
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
    #método que implementa la resta de vectores dispersos
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
  #Clase que permite representar un vector de vectores dispersos, es decir, una matriz dispersa
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
    #método que permite la indexación de elementos de la matriz por columnas
    def [](i)
      @matrix[i]
    end
    #
    def each
      super
    end
    #método que permite la asignación de elementos de la matriz por columnas
    def []=(i,other)
      for y in other.keys do
        puts "---- other[#{y}] #{other[y]}"
        @matrix[i][y] = other[y]
        puts "---- matrix[#{i}][#{y}] #{@matrix[i][y]}"
      end
    end
    #método que muestra por pantalla la matriz dispersa
    def imp
      for i in @matrix.keys do
        puts "#{i} ---- #{@matrix[i].to_s}" 
      end
    end
    #método que muestra por pantalla una columna de la matriz
    def col(j)
      c = {}
      for r in @matrix.keys do
        c[r] = @matrix[r].vector[j] if @matrix[r].vector.keys.include? j
      end
      SparseVector.new c
    end
    #método que permite la suma de matrices dispersas
    def +(other)
      resultado = SparseMatrix.new
      for i in other.matrix.keys do
        resultado.matrix[i] = other[i]
      end
      @matrix.each do |i, v1|
        @matrix[i].vector.each do |j, v2|
        	if other.matrix[i][j] == nil
        	  resultado.matrix[i] = @matrix[i]
        	else
        	  resultado.matrix[i][j] = @matrix[i][j]+other.matrix[i][j]
        	end
        end
      end
      resultado
    end
    #método que permite la resta de matrices dispersas
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
    #método que permite calcular la traspuesta de una matriz dispersa
    def traspuesta
      resultado = SparseMatrix.new
      for i in @matrix.keys do
        for j in @matrix[i].keys do
        	tmp = SparseVector.new
        	for x in @matrix.keys do
        	  for y in @matrix[x].keys do
        	    if j == y
        	      tmp[i] = @matrix[x][y]
        	    end
        	  end
        	end
        	resultado.matrix[j] = tmp
        end
      end
      resultado
    end
    #método que permite calcular el elemento máximo de una matriz dispersa
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
    #método que permite calcular el elemento mínimo de una matriz dispersa
    def min
      min = 9999999999999999999
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
  #Clase que permite representar matrices densas
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
    #Método que permite la indexación de elementos de la matriz
    def [](a,b)
      @m[a+(b*@c)]
    end
    #Método que permite la asignación de elementos de la matriz
    def []=(a,b,r)
      @m[a+(b*@c)] = r
    end
    #método que transforma la matriz en un vector de vectores. Devuelve un vector.
    def to_v
      v = []
      for i in (0...@c) do
        tmp = []
        for j in (0...@f) do
          tmp[j] = @m[i+(j*@c)]
        end
        v[i] = tmp
      end
      v
    end
    #Método que permite la multiplicación de matrices densas mediante programación funcional
    def *(other)
      tmp = self.tras; a = tmp.to_v; d = other.to_v;
      i = -1; j = -1; k= -1; l= -1;
      ex = Array.new()
      a.map { |b| i+=1; k=-1; d.map { |e| k+=1; l=-1; e.map { |f| l+=1; a[i][l]*d[k][l] }.inject (0) { |s,p| s+p } } }.map{ |r| r.each { |t| ex.push(t) } }
      return DenseMatrix.new(@c,@f, ex)
    end
    #Método que permite la suma de matrices densas
    def +(other)
      i=-1
      return DenseMatrix.new(@c,@f,other.m.map { |e| i+=1; e+@m[i]})
    end
    #Método que permite la resta de matrices densas
    def -(other)
      i = 0
      tmp = []
      while i < @f*@c
        tmp[i] = @m[i]-other.m[i]
        i=i+1
      end
      tmp
    end
    #Método que permite calcular el determinante de una matriz densa. (Recursivo)
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
    #Método que permite calcular la matriz adjunta de una matriz densa
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
    #Método que permite calcular la traspuesta de una matriz densa
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
    #Método que permite calcular la inversa de una matriz densa
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
    #método que permite mostrar por pantalla una matriz densa
    def imprimir
      for i in (0...@c*@f) do
        print "#{@m[i].round(2)}\t"
        if i % @c == 2
          print "\n"
        end
      end
    end
    #Método que permite hacer la división de matrices densas
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
      a = DenseMatrix.new(3,3,[1,2,3,4,5,6,7,8,9])
      b = DenseMatrix.new(3,3,[2,4,6,8,10,12,14,16,18])
      a.imprimir
      b.imprimir
      puts "-----------------------"
      c = a * b
      puts c.inspect
      c.imprimir
      # x = a.to_v
      # y = b.to_v
      # for i in (0...x.size) do
      #   for j in (0...x[i].size) do
      #     puts x[i][j]
      #   end
      # end
  end

end

