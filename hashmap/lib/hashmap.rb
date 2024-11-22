class HashMap

  def initialize
    @capacity = 0
    @load_factor = 0.75
  end

  def hash(key)
    hash_code = 0 #Startwert
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord } # Primzahl stellt sicher, dass die Zeichenreihenfolge eine Rolle spielt
       
    hash_code
  end
end