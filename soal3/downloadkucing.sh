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
    # echo $namafiletemp
	IFS='/' read -ra ADDR <<< "$namafiletemp"
	# echo ${ADDR[3]}
    namafiletemp=${ADDR[3]}
    #mengecek apakah nama file baru telah ada di log (seluruh gambar terdownload)
    # cek=$(awk -v namafileaa="$namafiletemp" '/namafileaa/ {print}' wgetkoceng.log.bak)
    
    cek=$(awk -v koceng="$namafiletemp" '
    BEGIN{count=0}
    {if( $0~koceng )count++}
    END{print count}
    ' wgetkoceng.log.bak)
    echo $cek

    #cek apakah $cek kosong?
    if [[ $cek>0 ]]
    then #apabila ada gambar duplikat maka gambar tsb. dipindah ke folder duplikat
        #mencari file duplikat terakhir dan mencari gambar duplikat keberapa
        echo "masuk DUPLICATE"
        lastfile=$(ls duplicate/ | sort -V | tail -n 1)
        namalastfile=${lastfile%.*}
        lastiter=${namalastfile:10}
        # memindahkan gambar duplikat ke folder duplicate
        mv "pdkt_kusuma_$iter.jpg" "duplicate/duplicate_$(($lastiter + 1)).jpg" 
    fi
    #log akan ditambah log baru
    cat wgetkocengtemp.log >> wgetkoceng.log.bak
done

