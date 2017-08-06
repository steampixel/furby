# run docker container
# proxy port 80 to local port 80
# use the device flag with dev/mem to allow gpio
# run this container as privileged container. This is required for gpio
# /device/snd is required for sound

#sudo docker run -d -p 80:80 \
#--name officefurby \
#--device /dev/mem \
#-v /dev/snd:/dev/snd \
#--privileged \
#steampixel/officefurby

#sudo docker run -d -p 80:80 \
#--name officefurby \
#--device /dev/snd \
#--privileged \
#steampixel/officefurby

sudo docker run -d -p 80:80 \
--name officefurby \
--privileged \
steampixel/furby

