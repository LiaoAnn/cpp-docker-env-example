# Stage 1: Build stage
FROM ubuntu:latest AS build

# 安裝必要的軟體包
RUN apt-get update && \
    apt-get install -y cmake g++ libboost-all-dev

# 複製項目文件到容器中
COPY . /app

# 在 build 目錄下建立項目
WORKDIR /app/build
RUN cmake ..
RUN make

# Stage 2: Final stage
FROM ubuntu:latest

# 安裝項目執行所需的軟體包
RUN apt-get update && \
    apt-get install -y libboost-all-dev

# 從第一階段中拷貝生成的可執行文件到最終階段
COPY --from=build /app/build/myapp /app/myapp

# 指定工作目錄
WORKDIR /app

# 定義容器執行的命令
CMD ["./myapp"]
