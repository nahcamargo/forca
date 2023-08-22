class Forca
  PALAVRAS = ["maça", "polvo", "quadro", "cafe"]
  attr_accessor :palavra_secreta, :tentativas, :letras_chutadas, :acertos

  def initialize 
    @palavra_secreta = PALAVRAS.sample
    @tentativas = 6
    @letras_chutadas = []
    @acertos = []
  end 

  def jogar 
    while tentativas > 0
      exibir_tabuleiro

      chute = pegar_chute
      next if letras_chutadas.include?(chute)

      letras_chutadas << chute

      if palavra_secreta.include?(chute)
        acertos << chute
      else
        self.tentativas -= 1
      end

      break if venceu?
    end

    finalizar_jogo
  end

  private

  def mostrar_forca(erros)
    puts "____________________"
    puts "|                  |"

    case erros
    when 1
      puts "|                  O"
    when 2
      puts "|                  O"
      puts "|                  |"
    when 3
      puts "|                  O"
      puts "|                 /|"
    when 4
      puts "|                  O"
      puts "|                 /|\\"
    when 5
      puts "|                  O"
      puts "|                 /|\\"
      puts "|                 /"
    when 6
      puts "|                  O"
      puts "|                 /|\\"
      puts "|                 / \\"
    else
      6.times { puts "|" }
    end
  end

  def exibir_tabuleiro
    mostrar_forca(6 - tentativas)
    palavra_display = palavra_secreta.chars.map { |letra| acertos.include?(letra) ? letra : "_" }.join(" ")
    puts palavra_display
    puts "Tentativas restantes: #{tentativas}"
    puts "Letras chutadas: #{letras_chutadas.join(', ')}" unless letras_chutadas.empty?
  end

  def pegar_chute
    print "Digite uma letra: "
    gets.chomp.downcase
  end

  def venceu?
    palavra_secreta.chars.all? { |letra| acertos.include?(letra) }
  end

  def finalizar_jogo
    if venceu?
      puts "Você venceu!"
    else
      puts "Você perdeu! A palavra era '#{palavra_secreta}'."
    end
    print "Jogar novamente? (s/n): "
    resposta = gets.chomp.downcase
    if resposta == 's'
      Forca.new.jogar
    end
  end
end

Forca.new.jogar