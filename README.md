# My Development environment

Configuration for a Docker image that contains my development environment.

## Build the image

```
docker build . --no-cache --build-arg GITHUB_USERNAME=[USERNAME] --build-arg GITHUB_TOKEN=[TOKEN] --build-arg GITHUB_EMAIL=[GITHUB_EMAIL] --build-arg GITHUB_NAME=[GITHUB_NAME] -t dev
```

## Run the container

```
docker run -v ~/dev:/dev -e TERM=$TERM -e TZ=CET -ti dev
```

## Deattach from the interactive session

```
<Ctrl+P><Ctrl+Q>
```

## Attach to interactive session

```
docker attach [IMAGE_ID]
```
