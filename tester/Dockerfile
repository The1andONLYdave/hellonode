FROM ubuntu:xenial
RUN apt-get update && apt-get install -yq curl
COPY test.sh .
CMD ["bash", "test.sh"]
