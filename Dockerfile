# Stage 1: Build stage
FROM alpine:latest AS build

# 安裝必要的軟體包和 WebSocketpp
RUN apk update && \
    apk add --no-cache build-base cmake boost-dev git \
    && apk add --no-cache --virtual .build-deps curl \
    && mkdir /tmp/websocketpp \
    && cd /tmp/websocketpp \
    && curl -L -O https://github.com/zaphoyd/websocketpp/archive/refs/tags/0.8.2.tar.gz \
    && tar -xzf 0.8.2.tar.gz --strip 1 \
    && mv websocketpp /usr/include/ \
    && cd / && rm -rf /tmp/websocketpp \
    && apk del .build-deps

# 複製項目文件到容器中
COPY . /app

# 在 build 目錄下建立項目
WORKDIR /app/build
RUN cmake ..
RUN make

# Stage 2: Final stage
FROM alpine:latest

# 安裝項目執行所需的軟體包和 WebSocketpp
RUN apk update && \
    apk add --no-cache boost boost-system boost-filesystem

# 從第一階段中拷貝生成的可執行文件到最終階段
COPY --from=build /app/build/myapp /app/myapp

# 指定工作目錄
WORKDIR /app

# 定義容器執行的命令
CMD ["./myapp"]

# 暴露端口
EXPOSE 9002