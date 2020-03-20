find . -type f -exec chmod u=rw,go=r {} \;
find . -type d -exec chmod u=rwx,go=rx {} \;
find . -type f \( -name '*.sh' -or -name '*.bash' -or -name 'Makefile' \) -exec chmod u=rwx,go=rx {} \;
