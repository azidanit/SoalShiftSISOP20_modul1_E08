#!bin/bash

#mengambil argumen filename
file=$1
#mengambil namafile tanpa extension
namafile=${file%.*}

#mengambil waktu (jam) file dibuat
jam=$(date -r $file +"%H")

#membuat string berisi chiper untuk transformasi string (huruf kecil)
hrfkecil=''
for hrf in {a..z}; do
	hrfkecil="$hrfkecil""$hrf"
done
#untuk mengulang abjad apabila lebih dari 26 (y,z,a,b)
hrfkecil="$hrfkecil""$hrfkecil"

#transformasi string a..z ke A..Z
hrfbesar=$(echo "$hrfkecil" | tr '[a-z]' '[A-Z]') 

#encrypt filename dengan aturan a..z + jam skrg (mengganti setiap a+jam,b+jam,c+jam,...z+jam dengan a,b,c...z)
decryptedfile=$(echo "$namafile" | tr "${hrfkecil:${jam}:26}" "${hrfkecil:0:26}" | tr "${hrfbesar:${jam}:26}" "${hrfbesar:0:26}")

#rename encrypted filename ke decrypted filename
$(echo mv $file "$decryptedfile.txt")
 