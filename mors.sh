#!/bin/bash
#Fatih ÖNDER https://github.com/cektor

# Harfleri Mors koduna çeviren sözlük
declare -A morse_code=(
  ["A"]=".-" ["B"]="-..." ["C"]="-.-." ["D"]="-.." ["E"]="."
  ["F"]="..-." ["G"]="--." ["H"]="...." ["I"]=".." ["J"]=".---"
  ["K"]="-.-" ["L"]=".-.." ["M"]="--" ["N"]="-." ["O"]="---"
  ["P"]=".--." ["Q"]="--.-" ["R"]=".-." ["S"]="..." ["T"]="-"
  ["U"]="..-" ["V"]="...-" ["W"]=".--" ["X"]="-..-" ["Y"]="-.--"
  ["Z"]="--.." ["1"]=".----" ["2"]="..---" ["3"]="...--" ["4"]="....-"
  ["5"]="....." ["6"]="-...." ["7"]="--..." ["8"]="---.." ["9"]="----."
  ["0"]="-----"
)

# Mors kodundan harflere çeviren ters sözlük
declare -A text_code
for letter in "${!morse_code[@]}"; do
  text_code[${morse_code[$letter]}]=$letter
done

while true; do
  # Kullanıcıdan giriş alma
  read -p "Metin veya Morse kodu girin (Morse kodu için her harfi boşlukla ayırın, kelime arası için '/'). Çıkmak için 'exit' yazın: " input
  
  # Çıkış kontrolü
  if [[ $input == "exit" ]]; then
    echo "Çıkış yapılıyor..."
    break
  fi
  
  # Girişin Morse kodu mu yoksa normal metin mi olduğunu belirleme
  echo -ne "\e[32m"  # Yeşil renk başlat
  
  if [[ $input == *"."* || $input == *"-"* ]]; then
    # Morse kodunu metne çevirme
    IFS=' ' read -ra morse_chars <<< "$input"
    for morse_char in "${morse_chars[@]}"; do
      if [[ "$morse_char" == "/" ]]; then
        echo -n " "  # Kelime arası boşluk
      else
        echo -n "${text_code[$morse_char]}"
      fi
    done
    echo  # Satır sonu
  else
    # Normal metni Morse koduna çevirme
    input=${input^^}  # Büyük harfe dönüştür
    for (( i=0; i<${#input}; i++ )); do
      char="${input:$i:1}"
      if [[ "$char" == " " ]]; then
        echo -n " / "  # Kelime arası boşluk
      else
        echo -n "${morse_code[$char]} "
      fi
    done
    echo  # Satır sonu
  fi
  
  echo -ne "\e[0m"  # Renk sıfırla
done

