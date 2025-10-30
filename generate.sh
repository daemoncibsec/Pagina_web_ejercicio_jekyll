#!/bin/sh

config_folder=$(pwd)
version=$(cat .version)
str="Automatic deployment. Ver.$version"
new_ver=$(($(cat .version)+1))

echo "[\e[32m+\e[0m] Generating webpage.\n"

jekyll build >/dev/null

sleep 3 

echo "[\e[32m+\e[0m] Changing the repository to push the changes.\n"

cp -R _site/* ../Pagina_web_ejercicio_jekyll
cd ../Pagina_web_ejercicio_jekyll

echo "[\e[32m+\e[0m] Performing the commit.\n"

git add .
git commit -am "$str"
commit_status=$(echo $?)
echo "\n"

if [ $commit_status -eq 0 ]; then
	git push origin main
	echo "\n"
else
	echo "[\e[31m-\e[0m] Error while doing commit. Stopping script's execution.\n"
	exit
fi

echo "[\e[32m+\e[0m] Script completed.\n"

cd $config_folder
echo $new_ver > .version
