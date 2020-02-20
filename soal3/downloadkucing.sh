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
    cek=$(awk '{$namafiletemp}' wgetkoceng.log.bak)
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
    cat wgetkocengtemp.log >> wgetkoceng.log.bak
done

