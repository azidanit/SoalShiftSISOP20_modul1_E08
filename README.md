
# SoalShiftSISOP20_modul1_E08

Penyelesaian Soal Shift Modul 1 SISOP 2020

  

<h3>Nomor 2</h3>
Script yang dapat membuat password random dan menyimpannya dengan enkripsi dari filename dari argumen bash.
Berikut adalah code untuk **membuat file ter-enkripsi** dengan filename yang diberikan, serta penjelasannya:

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
	for  hrf  in {a..z}; do
		hrfkecil="$hrfkecil""$hrf"
	done
	#untuk mengulang abjad apabila lebih dari 26 (y,z,a,b)
	hrfkecil="$hrfkecil""$hrfkecil"
	
	#transformasi string a..z ke A..Z
	hrfbesar=$(echo "$hrfkecil" | tr '[a-z]' '[A-Z]')

	#encrypt filename dengan aturan a..z + jam skrg (mengganti setiap a,b,c,d...z dengan a+jam,b+jam,..z+jam)
	encryptedfile=$(echo "$namafile" | tr "${hrfkecil:0:26}" "${hrfkecil:${jam}:26}" | tr "${hrfbesar:0:26}" "${hrfbesar:${jam}:26}")

	#memasukkan generated password ke encrypted filename
	echo  "$genpass" > "$encryptedfile.txt"
Script diatas digunakan untuk **mengenkripsi filename** yang diberikan pada argumen.
Untuk menggunakannya ketik perintah dibawah (pastikan path sudah sesuai ~/soal2/)   
> $ bash soal2_encrypt.sh passwordintegra.txt

dari perintah di atas, script akan membuat file baru bernama  (dibuat jam 02)**"rcuuyqtfkpvgitc.txt"** menggunakan chipper.
berisi 28 karakter random generated password "MjI1NTk4OWIxMjg3Y2EzODFhNzRh"

Sedangkan, untuk mengetahui nama asli dari file tersebut (**decrypt**) digunakan script dibawah ini:

    #!bin/bash
        
    #mengambil argumen filename
    file=$1
    
    #mengambil namafile tanpa extension    
    namafile=${file%.*}
        
    #mengambil waktu (jam) file dibuat
    jam=$(date -r $file +"%H")

    #membuat string berisi chiper untuk transformasi string (huruf kecil)
    hrfkecil=''
    for  hrf  in {a..z}; do
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
Script diatas digunakan untuk **mendekripsi filename** yang diberikan pada argumen.
Untuk menggunakannya ketik perintah dibawah (pastikan path sudah sesuai ~/soal2/)   

> $ bash soal2_decrypt.sh rcuuyqtfkpvgitc.txt

dari perintah di atas, script akan merename file bernama  (dibuat jam 02)**"rcuuyqtfkpvgitc.txt"** menjadi **passwordintegra.txt** menggunakan chipper. file tersebut berisi 28 karakter random generated password "MjI1NTk4OWIxMjg3Y2EzODFhNzRh"
