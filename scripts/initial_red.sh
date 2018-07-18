echo node red initiation begin

check=$(yum list -q installed nodejs)
if [[ $check == "" ]];
then
  echo "installing nodejs"
  curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
    sudo yum install -y -q nodejs
fi

npm install -g npm-autoinit

npm config set onload-script npm-autoinit/autoinit

npm i node-gyp --save-dev

npm i bcrypt --save-dev

npm i node-red --save-dev

npm uninstall node-red-contrib-ui

npm i node-red-dashboard --save-dev

npm install pm2@latest -g

pm2 startup

pm2 start /home/vagrant/node_modules/node-red/red.js -- --settings /home/vagrant/node_modules/node-red/settings.js

pm2 save

echo node red initiation end.
