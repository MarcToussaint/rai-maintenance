read -p " *** WARNING: This will rm ALL local files/changes (e.g. project/temporary/data files) - do you want to continue? -- y/[n] ?" yn
case $yn in
     y|Y)
	git reset --hard
	git clean -f -d -x
	bin/createMakefileLinks.sh
	colormake -k -j4 src examples
	;;
    *) ;;
esac
