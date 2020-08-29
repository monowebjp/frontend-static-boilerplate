#!/bin/sh

echo "------------------------------------"
echo "Please input a PROJECT_NAME."
echo "------------------------------------"
read PROJECT_NAME
echo ""
echo "------------------------------------"
echo "Please input a HOST_NAME."
echo "------------------------------------"
read HOST_NAME
echo ""
echo "------------------------------------"
echo "Please input a PUBLISH_URL."
echo "------------------------------------"
read PUBLISH_URL
echo ""
echo "------------------------------------"
echo "Please input a STAGING_URL."
echo "------------------------------------"
read STAGING_URL

grep "$HOST_NAME" /private/etc/hosts

if [ $? = 0 ]; then
    echo "hostsが追加されているので追記はSkipします"
else
    echo "hostsに追記します"
    echo "192.168.33.1  $HOST_NAME" >> /private/etc/hosts
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
mv frontend-static-boilerplate-master/.node-version ./.node-version
rm -r frontend-static-boilerplate-master
rm -r org-chimata-ssl-certs



sed -i -e "s/LOCAL_HOST_NAME/$HOST_NAME/g" ./bs-config.js
sed -i -e "s/LOCAL_HOST_NAME/$HOST_NAME/g" ./docker-compose.yml
sed -i -e "s/LOCAL_HOST_NAME/$HOST_NAME/g" ./docker/default.conf

REPOSITORY_URL=$(git config --get remote.origin.url)
sed -i -e "s/https:\/\/github.com\/monowebjp\/frontend-static-boilerplate.git/$REPOSITORY_URL/g" ./package.json

sed -i -e "s/frontend-static-boilerplate/$PROJECT_NAME/g" ./package.json
sed -i -e "s/PROJECT_NAME/$PROJECT_NAME/g" ./README.md
sed -i -e "s/PROJECT_NAME/$PROJECT_NAME/g" ./fractal.js
sed -i -e "s/PROJECT_NAME/$PROJECT_NAME/g" ./styleguide/index.md
sed -i -e "s/PUBLISH_URL/$PUBLISH_URL/g" ./styleguide/index.md
sed -i -e "s/STAGING_URL/$STAGING_URL/g" ./styleguide/index.md

rm *-e

rm setup.sh

find . -exec chmod 777 {} +

yarn install
#docker-compose up -d
#npm start

echo '環境を構築しました'