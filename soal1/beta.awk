BEGIN{FS=OFS="\t";min_reg=0}
FNR == 1 {next}
{min_reg=$31} 
{count[$13]++}
{printf "%d",min_reg}
END {
	for (region in count)
		if(count[region]>max_reg) {max_reg=count[region]}
	
	
}

