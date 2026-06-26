# gomodd

Go 开发环境 Docker 镜像，内置 [modd](https://github.com/cortesi/modd) 文件监听和热重载工具。

## 特性

- 🐹 基于官方 `golang` 镜像
- 🔧 预装 `modd` 热重载工具
- 🌏 已配置中国 Go 代理（`goproxy.cn`）
- ⏰ 时区设置为 `Asia/Shanghai`
- 📦 预装 `git`、`make` 等常用工具
- 🏗️ 支持多架构（`linux/amd64`, `linux/arm64`）
- 📜 严格遵守开源许可证要求

## 支持的版本

| 标签 | Go 版本 | modd 版本 | 说明 |
|------|---------|----------|------|
| `v1.24.2` | 1.24.2 | 0.8 | 最新稳定版 |
| `v1.23.4` | 1.23.4 | 0.8 | 长期支持 |
| `latest` | 1.24.2 | 0.8 | 默认标签 |

## 快速开始

### 基础使用

```bash
docker run --rm -it luo2009/gomodd:v1.24.2
```

### 挂载项目并监听

```bash
docker run --rm -it \
  -v $(pwd):/go/src \
  -w /go/src \
  luo2009/gomodd:v1.24.2
```

### Docker Compose 示例

```yaml
services:
  dev:
    image: luo2009/gomodd:v1.24.2
    volumes:
      - .:/go/src
    working_dir: /go/src
    environment:
      - GOPROXY=https://goproxy.cn,direct
    command: modd
```

## 环境变量

| 变量 | 默认值 | 说明 |
|------|--------|------|
| `GOPROXY` | `https://goproxy.cn,direct` | Go 模块代理 |
| `TZ` | `Asia/Shanghai` | 时区 |
| `CGO_ENABLED` | `0` | 禁用 CGO |

## 构建镜像

### 本地构建

```bash
# 构建默认版本
docker build -t luo2009/gomodd:v1.24.2 .

# 构建指定 Go 版本
docker build --build-arg GO_VERSION=1.23.4 -t luo2009/gomodd:v1.23.4 .
```

### 使用 Makefile

```bash
make build          # 构建镜像
make push           # 构建并推送
make test           # 测试镜像
make clean          # 清理本地镜像
```

## 使用示例

查看 `example/` 目录中的 `modd.conf` 配置文件示例。

## 许可证

本项目使用 MIT License - 详见 [LICENSE](LICENSE)

### 第三方组件

| 组件 | 作者 | 许可证 | 来源 |
|------|------|--------|------|
| modd | Aldo Cortesi | MIT | https://github.com/cortesi/modd |

modd 的完整许可证文本见：
https://github.com/cortesi/modd/blob/main/LICENSE

## 相关链接

- [modd GitHub](https://github.com/cortesi/modd)
- [Go 官方镜像](https://hub.docker.com/_/golang)
- [本项目 GitHub](https://github.com/luo2009/gomodd)
