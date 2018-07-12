# go build image
FROM golang:1.10 as build
RUN go get -u k8s.io/git-sync/cmd/git-sync

# runtime image
FROM golang:1.10

RUN mkdir -p /app /etc/git-secret /git
COPY --from=build /go/bin/git-sync /app/

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-client && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/app/git-sync"]
