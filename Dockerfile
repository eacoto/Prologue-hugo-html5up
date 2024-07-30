FROM chainguard/hugo as build

ADD . /home/site

WORKDIR /home/site

CMD hugo --gc --minify --baseURL=http://localhost:3000/

FROM lipanski/docker-static-website:latest

# Copy your static files
COPY --from=build /home/site/public .

EXPOSE 3000

CMD ["/busybox-httpd", "-f", "-v", "-p", "3000"]

## How to build and run this site manually with docker
# 1. docker build . -t <some_tag_name>
# 2. docker run -it --rm --detach -p 3000:3000 <some_tag_name>
# 3. docker stop <container_id>

## You can also use docker compose
# docker compose up