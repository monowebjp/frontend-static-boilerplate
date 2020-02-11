#!/bin/sh

grep "$1" /private/etc/hosts

if [ $? = 0 ]; then
    echo "hostsが追加されているので追記はSkipします"
else
    echo "hostsに追記します"
    echo "127.0.0.1  $1" >> /private/etc/hosts
fi

curl -L -O https://github.com/monowebjp/frontend-static-boilerplate/archive/master.zip

unzip master.zip

rm master.zip
rm frontend-static-boilerplate-master/README.md
rm frontend-static-boilerplate-master/setup.sh

mv frontend-static-boilerplate-master/* .
mv frontend-static-boilerplate-master/.editorconfig ./.editorconfig
mv frontend-static-boilerplate-master/.eslintrc.json ./.eslintrc.json
mv frontend-static-boilerplate-master/.gitignore ./.gitignore
mv frontend-static-boilerplate-master/.stylelintrc ./.stylelintrc
rm -r frontend-static-boilerplate-master

sed -i -e "s/LOCAL_HOST_NAME/$1/g" ./bs-config.js
sed -i -e "s/LOCAL_HOST_NAME/$1/g" ./docker-compose.yml
sed -i -e "s/LOCAL_HOST_NAME/$1/g" ./docker/nginx.conf
rm bs-config.js-e
rm docker-compose.yml-e
rm docker/nginx.conf-e

rm setup.sh