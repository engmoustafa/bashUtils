args=("$@")
echo cp ~/.ssh/config_${args[0]} ~/.ssh/config
cp ~/.ssh/config_${args[0]} ~/.ssh/config
ssh-add -K ~/.ssh/id_rsa_${args[0]}