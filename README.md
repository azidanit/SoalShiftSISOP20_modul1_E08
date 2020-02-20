
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

<h3> Nomor 3 </h3>
Scipt yang dapat mendownload gambar dari wget. Serta, dijalankan setiap 8 jam sejak pukul 06:05 setiap harinya, kecuali hari sabtu.

**Script  Download Kocheng :**  beserta penjelasan

	#!bin/bash

	#pindah gambar ke folder kenangan dengan iterasi 28 gambar
	for ((iter=1; iter<=28; iter=iter+1))
	do
		#mencari gambar terakhir
		lastfileken=$(ls kenangan/ | sort -V | tail -n 1)
		#angka gambar terakhir
		namalastfileken=${lastfileken%.*}
		lastiterken=${namalastfileken:9}
		#memindahkan gambar di main directory ke kenangan dan rename jadi kenangan_x
		mv "pdkt_kusuma_$iter.jpg" "kenangan/kenangan_$(($lastiterken + 1)).jpg"
	done


	#download 28 gambar baru
	for ((iter=1; iter<=28; iter=iter+1))
	do
		#download gambar dari server
		$(echo wget --output-document "pdkt_kusuma_$iter.jpg" -o "wgetkocengtemp.log" "https://loremflickr.com/320/240/cat")
		#mencari nama asli file dari server 
		namafiletemp=$(awk '/Location:/ {print $2}' wgetkocengtemp.log)
		#mengecek apakah nama file baru telah ada di log (seluruh gambar terdownload)
		cek=$(awk '{$namafiletemp}' wgetkoceng.log)
		echo $cek
	
		
		#cek apakah $cek kosong?
		if [ ! -z $cek ]
		then #apabila ada gambar duplikat maka gambar tsb. dipindah ke folder duplikat
			#mencari file duplikat terakhir dan mencari gambar duplikat keberapa
			echo "masuk sini"
			lastfile=$(ls duplicate/ | sort -V | tail -n 1)
			namalastfile=${lastfile%.*}
			lastiter=${namalastfile:10}
			# memindahkan gambar duplikat ke folder duplicate
			mv "pdkt_kusuma_$iter.jpg" "duplicate/duplicate_$(($lastiter + 1)).jpg" 
		fi
		#log akan ditambah log baru
		cat wgetkocengtemp.log >> wgetkoceng.log
	done

**Sebelum mengeksekusi** pastikan telah membuat folder bernama "duplicate" dan "kenangan" dengan command:
>$ mkdir duplicate kenangan

Lalu tambahkan script pada crontab dengan membuka file crontab:
>$ crontab -e

Lalu tambahan code dibawah ini, di bagian paling bawah file (sesuaikan **PATH TO SCRIPT FOLDER** sesuai posisi folder script Anda & pastikan tidak dicomment):
>5 6,14,22 * * 1-5,7 bash ~/(**PATH TO SCRIPT FOLDER**)/downloadkucing.sh

Lalu, Save -> Quit dengan tekan (Ctrl + X), Lalu tekan "Y", Lalu "Enter"

