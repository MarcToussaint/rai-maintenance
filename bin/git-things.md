

## push all (remote) branches to a new remote:

git push <new-remote> refs/remotes/<old-remote>/*:refs/heads/*
git push lis refs/remotes/origin/*:refs/heads/*

## re-write a repo

download:
https://rtyley.github.io/bfg-repo-cleaner/

git config pack.windowMemory 10m
git config pack.packSizeLimit 20m

alias bfg="java -jar /home/mtoussai/Downloads/bfg-1.13.0.jar"

first remove large files, cleanup repo, do this in MASTER!, then commit

clone bare mirror:

git clone --mirror ssh://gitolite3@animal.informatik.uni-stuttgart.de/marc_write_private.git


git clone --mirror ~/write

du -sh write.git

bfg --strip-blobs-bigger-than 100M --delete-files '*.{mp4,avi,zip,pdf,flv}' write.git

cd write.git
git reflog expire --expire=now --all && git gc --prune=now --aggressive
git remote add lis git@gitlab.tubit.tu-berlin.de:marc-private/write.git
git push lis --all



git clone --mirror ../mlr

du -sh mlr.git

bfg --strip-blobs-bigger-than 20M --delete-files '*.{mp4,avi,zip,pdf,flv,tgz,so,exe,so,o,a,out,arr,png,PNG,jpg,JPG,ppm,tif,svg,dae,ply,obj,stl,STL}' mlr.git

cd mlr.git
du -sh .
git reflog expire --expire=now --all && git gc --prune=now --aggressive
du -sh .

git remote add lis git@gitlab.tubit.tu-berlin.de:marc-private/write.git
git push lis --all



git filter-repo --strip-blobs-bigger-than 1M
