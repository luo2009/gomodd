GO_VERSION ?= 1.24.2
MODD_VERSION ?= v0.8
IMAGE_NAME := luo2009/gomodd
TAG := v$(GO_VERSION)

.PHONY: build push clean test help

help:
	@echo "gomodd Docker 镜像构建工具"
	@echo ""
	@echo "用法:"
	@echo "  make build    - 构建镜像"
	@echo "  make push     - 构建并推送镜像"
	@echo "  make test     - 测试镜像"
	@echo "  make clean    - 清理本地镜像"
	@echo ""
	@echo "参数:"
	@echo "  GO_VERSION=$(GO_VERSION)  - Go 版本"
	@echo "  MODD_VERSION=$(MODD_VERSION) - modd 版本"

build:
	docker build \
		--build-arg GO_VERSION=$(GO_VERSION) \
		--build-arg MODD_VERSION=$(MODD_VERSION) \
		-t $(IMAGE_NAME):$(TAG) .
	@echo "✅ 构建完成：$(IMAGE_NAME):$(TAG)"

push: build
	docker push $(IMAGE_NAME):$(TAG)
	@echo "✅ 推送完成：$(IMAGE_NAME):$(TAG)"

clean:
	docker rmi $(IMAGE_NAME):$(TAG) 2>/dev/null || true
	@echo "🗑️ 已清理本地镜像"

test:
	docker run --rm $(IMAGE_NAME):$(TAG) --version
	@echo "✅ 测试通过"
