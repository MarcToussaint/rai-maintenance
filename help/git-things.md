

## push all (remote) branches to a new remote:

git push <new-remote> refs/remotes/<old-remote>/*:refs/heads/*
git push lis refs/remotes/origin/*:refs/heads/*

## transfer to new remote

git pull --all
git remote add tub git@git.tu-berlin.de:lis/rai.git
git push tub refs/remotes/origin/*:refs/heads/*


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

bfg --convert-to-git-lfs "*.{pdf,PDF,eps,EPS,jpg,JPG,png,PNG,mp4,zip}" --no-blob-protection marc_write_private.git

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

### filter-repo

To delete a path!!! (stripping does not really delete!)
git filter-repo --path usr --invert-paths
git filter-repo --strip-blobs-bigger-than 1M

git filter-repo --path-glob *.gz --path-glob *.zip --path-glob *.avi --path-glob *.mp4 --path-glob *.mov --path-glob *.webm --invert-paths

performed on bare clone of marc_write_private
git filter-repo --path-glob *.gz --path-glob *.zip --path-glob *.avi --path-glob *.mp4 --path-glob *.mov --path-glob *.webm --invert-paths --force
git filter-repo --path zotero  --invert-paths
git filter-repo --path reviews  --invert-paths
git filter-repo --path 20/RSSorga/papers/submissions --invert-paths

git filter-repo --path 05 --path 06 --path 07 --path 08 --path 09 --path 10 --path 11 --path 12 --path 13 --path 14 --invert-paths

----

git init...
git remote add...
git lfs track "*.pdf" "*.PDF" "*.eps" "*.EPS" "*.jpg" "*.JPG" "*.png" "*.PNG" "*.mp4" "*.zip"
git add .gitattributes
git add .gitignore #COPY FROM WRITE
git add .

