# check the existence of data folder
if [ ! -d data ]; then
    mkdir -p data
fi

# check the existence of the xware container
# build the container if is not exists
docker images | grep docker-xware
if [ ! $? -eq 0 ]; then
    docker build -t docker-xware .
fi

# start a named container: xware
docker run -d --privileged=true \
        --name=xware \
        -v $(pwd)/data:/app/TDDOWNLOAD \
        -v $(pwd)/thunder/bin:/app/bin \
    docker-xware

# if docker is already running, or the host system was restart,
# then restart the container
if [ ! $? -eq 0 ]; then
    docker restart xware
fi
