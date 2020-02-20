#!bin/bash

#mengambil argumen filename
file=$1
#mengambil namafile tanpa extension
namafile=${file%.*}
#generate password dengan sha256sum - base64 sepanjang 28 karakter
genpass=$(date +%s | sha256sum | base64 | head -c 28)

#mengambil waktu (jam)
jam=$(date +%H)

#membuat string berisi chiper untuk transformasi string (huruf kecil)
hrfkecil=''
for hrf in {a..z}; do
	hrfkecil="$hrfkecil""$hrf"
done
#untuk mengulang abjad apabila lebih dari 26 (y,z,a,b)
hrfkecil="$hrfkecil""$hrfkecil"
#transformasi string a..z ke A..Z
hrfbesar=$(echo "$hrfkecil" | tr '[a-z]' '[A-Z]') 

#encrypt filename dengan aturan a..z + jam skrg (mengganti setiap a,b,c,d...z dengan a+jam,b+jam,...z+jam)
encryptedfile=$(echo "$namafile" | tr "${hrfkecil:0:26}" "${hrfkecil:${jam}:26}" | tr "${hrfbesar:0:26}" "${hrfbesar:${jam}:26}")

#memasukkan generated password ke encrypted filename 
echo "$genpass" > "$encryptedfile.txt"
 