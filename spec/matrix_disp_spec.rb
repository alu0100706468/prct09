#require File.join(File.dirname(__FILE__), 'spec_helper')
require_relative 'spec_helper'


module Math
	describe Fraccion do
            before :each do
              @c = Fraccion.new(10, 20)
            end
            #Primera prueba, quinto push al bitbucket.
                # => Debe existir un numerador
            context "1. Cuando se pida el numerador" do
                      it "este debe existir y debe ser del tipo Fixnum" do
                        expect(@c.num).to be_a_kind_of(Fixnum) #comprueba que lo que devuelve es un número
                      end
            end
            #Segunda prueba, 6º push al bitbucket.
            # => Debe existir un denominador
            context "2. Cuando se pida el denominador" do
                    it "este debe existir y debe ser del tipo Fixnum" do
                            expect(@c.denom).to be_a_kind_of(Fixnum) #comprueba que lo que devuelve es un número
                    end
            end
            #Tercera prueba, 7º push al bitbucket.
            # => Debe de estar en su forma reducida
            context "3. Cuando se cree un numero fraccionario" do
                    it "El constructor debe construirlo a la forma reducida" do
                            expect(@c.denom).to eq(2) #comprueba que al construir con denominador 20, lo reduce a 2
                            expect(@c.num).to eq(1) #comprueba que al construir con numerador 10, lo reduce a 1
                    end
            end
                   #Cuarta prueba, 8º push 
                   # => Se debe invocar al metodo num() para obtener el numerador
                   context "4. Si se quiere acceder al atributo del numerador" do
                           it "se debe invocar al metodo num()" do
                                   expect(@c.num).to be_a_kind_of(Fixnum) 
                                   expect(@c.num).to eq(1)
                           end
                   end
                   #Quinta prueba, 9º push 
                   # => Se debe invocar al metodo denom() para obtener el denominador
                   context "5. Si se quiere acceder al atributo del denominador" do
                           it "se debe invocar al metodo denom()" do
                                   expect(@c.denom).to be_a_kind_of(Fixnum)
                                   expect(@c.denom).to eq(2)
                           end
                   end
                
                #Sexta prueba, 10º push
                   # => Se debe mostar por la consola la fraccion de la forma: a/b, donde a es el numerador y b el denominador
                   context "6. cuando se pida mostrar la fraccion" do
                           it "Se debe mostrar en la forma a/b, donde a es el numerador y b el denominador" do
                                   expect(@c.to_s).to eql("#{@c.num}/#{@c.denom}") #comprueba que lo que devuelve la función es de la forma a/b
                           end
                   end
                   #Séptima prueba, 11º push
                   # => Se debe mostar por la consola la fraccion en formato flotante
                   context "7. cuando se pida mostrar la fraccion" do
                           it "Se debe mostrar en formato flotante" do
                                   expect(@c.to_sf).to eq("#{@c.num.to_f}/#{@c.denom.to_f}")    #comprueba que lo que devuelve la función es de la forma a.0/b.0
                           end
                   end
      
    #Octava prueba, 12º push
      # => Se debe comparar si dos fracciones son iguales con ==
      context "8. Si se quieren comparar dos fracciones" do
        it "Se debe hacer usando ==" do 
          d = Fraccion.new(20, 40)
          expect(@c == d).to eq(true | false) #comprueba que la función de comparación devuelve true o false
          expect(@c == d).to eq(true) #comprueba que en este caso, la función debe dar true
        end
      end
      #Novena prueba, 13º push
      # => Se debe calcular el valor absoluto de una fraccion con el metodo abs
      context "9. Si se quiere calcular el valor absoluto de la fraccion" do 
        it "Se debe hacer usando abs" do
          d = Fraccion.new(-10,-20)
          d.abs
          expect(d.num).to eq(1) #Comprueba que el valor obtenido es el valor absoluto y reducido del numerador
          expect(d.denom).to eq(2) #Comprueba que el valor obtenido es el valor absoluto y reducido del denominador
        end
      end
      #Décima prueba, 14º push
      # => Se debe calcular el reciproco de una fraccion con el metodo reciprocal
      context "10. Si se quiere calcular el reciproco de la fraccion" do
        it "Se debe hacer usando abs" do
          @c.reciprocal
          expect(@c.num).to eq(2)
          expect(@c.denom).to eq(1)
        end
      end
      #11ª Prueba, 15º push
      # => Se debe calcular el opuesto de una fraccion con -
      context "11. Si se quiere calcular el opuesto de una fraccion" do
        it "Se debe hacer usando -" do
          -@c
          expect(@c.num).to eq(-1)
          expect(@c.denom).to eq(2)
        end
      end
      
      #12ª prueba, 15º push
      # => Se debe sumar dos fracciones con + y dar el resultado de forma reducida
      context "12. Si se quieren sumar dos fracciones" do
        it "se debe hacer usando + y el resultado debe estar en forma reducida" do
          d = Fraccion.new(35,21)
          resultado = @c + d
          expect(resultado.num).to eq(13)
          expect(resultado.denom).to eq(6)
        end
      end
      #13ª prueba, 16º push
      # => Se debe restar dos fracciones con - y dar el resultado de forma reducida
      context "13. Si se quieren restar dos fracciones" do
        it "se debe hacer usando - y el resultado debe estar en forma reducida" do
          d = Fraccion.new(7,28)
          resultado = @c - d
          expect(resultado.num).to eq(1)
          expect(resultado.denom).to eq(4)
        end
      end
      #14ª prueba, 17º push
      # => Se debe multiplicar dos fracciones con * y dar el resultado de forma reducida
      context "14. Si se quieren multiplicar dos fracciones" do
        it "se debe hacer usando * y el resultado debe estar en forma reducida" do
          d = Fraccion.new(3,14)
          resultado = @c * d
          expect(resultado.num).to eq(3)
          expect(resultado.denom).to eq(28)
        end
      end
      #15ª prueba, 18º push
      # => Se debe dividir dos fracciones con / y dar el resultado de forma reducida
      context "15. Si se quieren dividir dos fracciones" do
        it "se debe hacer usando / y el resultado debe estar en forma reducida" do
          d = Fraccion.new(21,8)
          resultado = @c / d
          expect(resultado.num).to eq(4)
          expect(resultado.denom).to eq(21)
        end
      end
      
      #16ª prueba, 19º push
      # => Se debe calcular el resto dos fracciones con % y dar el resultado de forma reducida
      context "16. Si se quiere calcular el resto de dos fracciones" do
        it "se debe hacer usando % y el resultado debe estar en forma reducida" do
          d = Fraccion.new(21,8)
          resultado = @c % d
          expect(resultado).to eq(4)
        end
      end
      
      context "PRUEBA DE CLASE: Si se quiere calcular el reciproco de una funcion partida por otra" do
        it "se debe usar divReciprocal" do
          d = Fraccion.new(1,34)
          resultado = @c.divReciprocal(d)
          expect(resultado.num).to eq(1)
          expect(resultado.denom).to eq(17)
        end
      end
      ######################################################
      ######################################################
      context "PRUEBA PRACTICA 7: Se debe poder usar el modulo comparable" do
        d = Fraccion.new(1,34)
        it "Con el operador <" do
          expect(d < @c).to eq(true)
        end
        it "Con el operador >" do
          expect(@c > d).to eq(true)
        end
        it "Con el operador <=" do
          e = Fraccion.new(1,2)
          expect(@c <= e).to eq(true)
        end
        it "Con el operador >=" do
          expect(@c >= d).to eq(true)
        end
        it "Con el operador between?" do
          e = Fraccion.new(5,16)
          expect(e.between?(d, @c)).to eq(true)
        end
      end
      ######################################################
      ######################################################
end

	describe SparseVector do
		before :each do
		  @p = SparseVector.new ({ 1 => 10, 2 => 22, 3 => 33 })
		  @q = SparseVector.new ({ 1 => 10, 2 => 20, 3 => 30 })
		end
		#Se debe poder indexar
		context "1. Si se quiere indexar cualquier elemento de la matriz" do
		  it "Debe hacerse mediante el operador []" do
                    expect(@p[2]).to be_a_kind_of(Fixnum)
                    expect(@p[2]).to eq(22)
		  end
		end
		#Debe poder sumar y restar
		context "2. Deben poderse hacer las siguientes operaciones basicas:" do
		  it "2.3 Suma" do
		    a = @p + @q
		    expect(a[1]).to eq(20)
		    expect(a[2]).to eq(42)
		    expect(a[3]).to eq(63)
		  end
		  it "2.4 Resta" do
		    a = @p - @q
		    expect(a[1]).to eq(0)
		    expect(a[2]).to eq(2)
		    expect(a[3]).to eq(3)
		  end
                end 
        end
	describe SparseMatrix do
		before :each do
		  @a = Fraccion.new(4,5)
		  @p = SparseMatrix.new 1000 => { 100 => @a, 500 => 200}, 20000 => { 1000 => 3, 9000 => 200}
		  @q = SparseMatrix.new 1500 => { 100 => @a, 500 => 20}, 20000 => { 1000 => 3, 9000 => 200}
		end
		#Se debe poder indexar
		context "1. Si se quiere indexar cualquier elemento de la matriz" do
		  it "Debe hacerse mediante el operador []" do
                    expect(@p.matrix[1000][100]).to be_a_kind_of(Fraccion)
                    expect(@p.matrix[1000][500]).to eq(200)
		  end
		end
		#Debe poder sumar y restar
		context "2. Deben poderse hacer las siguientes operaciones basicas:" do
		  it "2.3 Suma" do
		    a = @p + @q
		    expect(a.matrix[1000][100]).to eq(@a)
		    expect(a.matrix[20000][1000]).to eq(6)
		  end
		  it "2.4 Resta" do
		    a = @p - @q
		    expect(a.matrix[1000][100]).to eq(@a)
		    expect(a.matrix[20000][1000]).to eq(0)
		  end
                end 
        end
	describe Matriz do
		before :each do
		  
		end
		#Se debe poder indexar
		context "1. Segun el numero de ceros," do
		  it "Una matriz debe ser dispersa o Densa" do
                    a = Matriz.new(3,3,[1,2,3,4,5,6,7,8,9])
		    b = a.def_tipo
		    expect(b.class).to eq(Math::DenseMatrix)
		    c = Matriz.new(3,3,[1,0,0,0,0,6,0,0,9])
		    d = c.def_tipo
		    expect(d.class).to eq(Math::SparseMatrix)
		  end
		end
        end
	describe DenseMatrix do
                before :each do
		  @p = DenseMatrix.new(3, 3,[1,2,3,4,5,6,7,8,9])
		end
                #Debe existir el operador []
                context "1. Si se quiere indexar cualquier elemento de la matriz" do
		  it "Debe hacerse mediante el operador []" do
                    expect(@p[2,1]).to be_a_kind_of(Fixnum)
                    expect(@p[2,1]).to eq(6)
		  end
		end	
		#Debe poder realizar las siguientes operaciones básicas:
                context "2. Deben poderse hacer las siguientes operaciones basicas:" do
                        it "2.1 Multiplicacion" do
                                a = DenseMatrix.new(3, 3,[1,2,3,4,5,6,7,8,9])
                                b = a * @p
                                expect(b[1,1]).to be_a_kind_of(Fixnum)
				                        expect(b[1,1]).to eq(81)
                        end
                        it "2.2 Division" do
                                a = DenseMatrix.new(3, 3,[1,2,3,4,5,6,7,8,9])
                                a[1,2] = 15
                                b = @p/a
				                        expect(b[1,1]).to eq(52.5)
                        end
                        it "2.3 Suma" do
                                a = DenseMatrix.new(3, 3,[1,2,3,4,5,6,7,8,9])
                                b = []
                                b = a + @p
				                        expect(b[1,1]).to eq(10)
                        end
                        it "2.4 Resta" do
                                a = DenseMatrix.new(3, 3,[1,2,3,4,5,6,7,8,9])
                                b = []
                                b = a - @p
				                        expect(b[4]).to eq(0)
                        end
                end 
                context "Debe poderse encontrar un elemento específico" do
                  it "Que haga la búsqueda de un elemento multiplicado que supere a 6" do
                    a = DenseMatrix.new(2,3,[1,2,9,7,8,4])
                    expect(a.encontrar {|e| e*e > 6} ).to eq([0,2])
                  end
                end
                    
        end
end