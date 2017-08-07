# run docker container
# proxy port 80 to local port 80
# use the device flag with dev/mem to allow gpio
# run this container as privileged container. This is required for gpio
# /device/snd is required for sound

#--device /dev/mem \ #This is perhaps needed for gpio pins
#--device /dev/snd \ #This is perhaps needed for sound

sudo docker run -d -p 80:80 \
--name furby \
--privileged \
--restart unless-stopped \
steampixel/furby

