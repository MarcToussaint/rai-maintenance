X=(`find . -maxdepth 2 -name 'Makefile' -not -path '*retired*' -printf "%h "`)

echo "digraph G{"

# nodes:
for path in "${X[@]}"
do
    echo ${path#$"./"}
done

# edges:
for path in "${X[@]}"
do
    Y=(`grep "DEPEND" $path/Makefile`)
    for dep in "${Y[@]}"
    do
	if [ $dep != "DEPEND" ] && [ $dep != "=" ]; then
	   echo $dep "->" ${path#$"./"}
	fi
    done
done

echo "}"
