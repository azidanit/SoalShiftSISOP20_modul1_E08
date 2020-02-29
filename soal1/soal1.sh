#!/bin/bash
#Menggunakan FieldSeparator TAB
Region=$(awk -F"\t" '
{
	#Penjumlahan profit region dan disimpan pada array
	Array[$13]+=$21
}
END{
	#Mengambil salah satu nilai untuk dibandingkan
min=Array[$13]
for (i in Array) if( Array[i] != 0 && min >= Array[i])  #Mencari nilai terkecil
{
	min=Array[i]		#Memasukkan nilai terkecil
	region=i		#Memasukkan string nama region
}
print region			#Menampilkan output Region
}
' Sample-Superstore.tsv)	#File input

echo -e "1.a\nRegion profit paling sedikit = $Region" #Menampilkan output

State=$(awk -F"\t" -v region=$Region '	#Menggunakan -v untuk mengambil value
{					#dari variable awk yang sebelumnya.
if ( region == $13 )			#Melakukan pengecekkan pada region
{					#"Central"
	Array[$11]+=$21			#Melakukan penjumlahan profit pada State dengan region Central
	#Copy yang atas :v
	Array2[$11]=Array[$11]		
}
}
END{
asort(Array)						#Melakukan Sort descending array state
for(k=1; k<=2; k++)					#Perulangan untuk mencari 2 nilai terkecil
{
	for(i in Array2)				#Perulangan sejumlah index array pada Array2
	{
		if( Array[k] == Array2[i])		#Pengecekkan untuk nama dan nilai yang sudah di sort
		{
		print i					#Menampilkan nilai mulai dari terendah
		}
	}
}
}
' Sample-Superstore.tsv)		#Input file

echo -e "1.b\n2 state profit paling sedikit dari 1.a =" $State	#Menampilkan jawaban dari soal

awk -F"\t" -v state="$State" '					#Mengambil variable state dari awk sebelumnya
BEGIN{
split(state, Array, " ")
					#split untuk string state dan dipecah dimasukan ke array
}								#dengan separator space(" ")
{
if( $11 == Array[1] || $11 == Array[2] )			#Melakukan pengecekkan pada space untuk "Texas" dan "Illinois"
{
	product[$17]+=$21					#Melakukan penjumlahan nilai product dan disimpan pada array
	pdt[$17]=product[$17]
					#Copy atas :v
}
}
END{
asort(product)							#Melakukan Sort pada array product
print "1.c\n10 product profit paling sedikit dari 1.b = "	#Menampilkan untuk kalimat jawaban
for(t=1; t<=10; t++)						#Melakukan perulangan untuk mencari 10 product yang paling tidak profit
{								#pada state di atas
	for(k in pdt)						#Melakukan perulangan sebanyak array pdt (sungguh tidak efisien)
	{
		if( product[t] == pdt[k] )			#Pengecekkan hasil sort dengan nama product
		{
		print t, k, product[t]					#Menampilkan Product yang paling tidak profit mulai dari yang terendah
		}
	}
}
}
' Sample-Superstore.tsv						#Input file
