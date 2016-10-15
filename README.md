# My Development environment

Configuration for a Docker image that contains my development environment.

## Build the image

```
docker build . --no-cache --build-arg GITHUB_USERNAME=[USERNAME] --build-arg GITHUB_TOKEN=[TOKEN] --build-arg GITHUB_EMAIL=[GITHUB_EMAIL] --build-arg GITHUB_NAME=[GITHUB_NAME]
```

## Run vim

```
docker run -ti [IMAGE_UUID] vim
```
