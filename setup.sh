#!/bin/sh

echo "Please input a project name."
read PROJECT_NAME

echo "Please input a host name."
read HOST_NAME

grep "$HOST_NAME" /private/etc/hosts

if [ $? = 0 ]; then
    echo "hostsが追加されているので追記はSkipします"
else
    echo "hostsに追記します"
    echo "127.0.0.1  $HOST_NAME" >> /private/etc/hosts
fi

curl -L -O https://github.com/monowebjp/frontend-static-boilerplate/archive/master.zip

unzip master.zip

rm master.zip
rm frontend-static-boilerplate-master/README.md
rm frontend-static-boilerplate-master/setup.sh

mv frontend-static-boilerplate-master/README.sample.md ./README.md
rm frontend-static-boilerplate-master/README.sample.md

mv frontend-static-boilerplate-master/* .
mv frontend-static-boilerplate-master/.editorconfig ./.editorconfig
mv frontend-static-boilerplate-master/.eslintrc.json ./.eslintrc.json
mv frontend-static-boilerplate-master/.gitignore ./.gitignore
mv frontend-static-boilerplate-master/.stylelintrc ./.stylelintrc
rm -r frontend-static-boilerplate-master



sed -i -e "s/LOCAL_HOST_NAME/$HOST_NAME/g" ./bs-config.js
sed -i -e "s/LOCAL_HOST_NAME/$HOST_NAME/g" ./docker-compose.yml
sed -i -e "s/LOCAL_HOST_NAME/$HOST_NAME/g" ./docker/nginx.conf

REPOSITORY_URL=$(git config --get remote.origin.url)
sed -i -e "s/https:\/\/github.com\/monowebjp\/frontend-static-boilerplate.git/$REPOSITORY_URL/g" ./package.json

sed -i -e "s/frontend-static-boilerplate/$PROJECT_NAME/g" ./package.json
sed -i -e "s/PROJECT_NAME/$PROJECT_NAME/g" ./README.md

rm *-e

rm setup.sh

find . -exec chmod 777 {} +

yarn install
docker-compose up -d
npm start

echo '環境を構築しました'