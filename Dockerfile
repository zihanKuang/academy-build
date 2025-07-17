FROM alpine
ENV HUGO_VERSION=0.147.9
ENV GO_VERSION=1.22.4-r0
ENV NODE_VERSION=20.14.0

# Install base dependencies
RUN apk add --no-cache \
  curl git bash make libc6-compat \
  openssl unzip tar npm nodejs \
  go

# Install Hugo Extended
RUN curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz \
  | tar -xz -C /usr/local/bin hugo

# Verify tools
RUN hugo version && go version && node -v && npm -v

COPY . .

# Build Academy pages
RUN make academy-setup
RUN make academy-prod
