FROM golang:1.24.2-alpine

# 元数据标签
LABEL maintainer="luo2009 <luo2009@example.com>"
LABEL description="Go development environment with modd for hot reloading"
LABEL org.opencontainers.image.source="https://github.com/luo2009/gomodd"
LABEL org.opencontainers.image.description="Go + modd Docker image"
LABEL org.opencontainers.image.licenses="MIT"

# 环境变量
ENV GOPROXY=https://goproxy.cn,direct
ENV TZ=Asia/Shanghai
ENV CGO_ENABLED=0

# 安装系统依赖
RUN apk update --no-cache && \
    apk add --no-cache \
        tzdata \
        git \
        make \
        curl \
        ca-certificates && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# 安装 modd（固定版本）
ARG MODD_VERSION=v0.8
RUN go install github.com/cortesi/modd/cmd/modd@${MODD_VERSION} && \
    modd --version && \
    go version

# 创建许可证目录（MIT 许可证合规要求）
RUN mkdir -p /licenses && \
    printf 'The MIT License (MIT)\n\nCopyright (c) 2015 Aldo Cortesi\n\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the "Software"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE.\n' > /licenses/modd.LICENSE && \
    echo "modd - Copyright (c) 2015 Aldo Cortesi - MIT License" > /licenses/modd.NOTICE

# 工作目录
WORKDIR /go

# 健康检查
HEALTHCHECK --interval=30s --timeout=3s \
    CMD modd --version || exit 1

# 默认命令
ENTRYPOINT ["modd"]
