read -p " *** WARNING: This will rm ALL local files/changes (e.g. project/temporary/data files) - do you want to continue? -- y/[n] ?" yn
case $yn in
     y|Y)
	git reset --hard
	git clean -f -d -x
	bin/update-slice.sh
	bin/update-includes.sh
	make -f examples/MDP/mdp_pomdp/Makefile gui_ui.h
	cmake -DWITH_ROS=OFF -DWITH_G4=OFF .
	make -k -j4
	;;
    *) ;;
esac
