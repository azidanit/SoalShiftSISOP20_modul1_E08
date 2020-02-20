BEGIN{FS=OFS="\t"}
FNR == 1 {next} 
{count[$13]++}

END {
	for (region in count)
		{printf "%s %d\n",region,count[region]}
}

