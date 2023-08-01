param([parameter(mandatory=$true)][string]$m)

git add .

git commit -m $m
git push
