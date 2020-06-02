#name="ECMLocationExport_"
name="detailedStat_"
#name="WingDisc_"
#name="ECM_"
id="N01G00_"
#type=".vtk"
type=".txt"
name_general=$name$id
for filename in ${name_general}*${type}; do
    suffix="${filename##*[0-9]}"
    number="${filename%"$suffix"}"
    number="${number##*[!-0-9]}"
    number_no_left_zero=$(echo $number | sed 's/^0*//')
    echo $number_no_left_zero
    j=$((number_no_left_zero + 29))
    echo $j
    echo "***************"

    mv "$filename" ../../series_sum/dataoutput/${name_general}${j}${type}
done
