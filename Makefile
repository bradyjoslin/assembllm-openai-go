OPENAI_API_KEY := $(shell echo $$OPENAI_API_KEY)

build:
	@mkdir -p ./dist
	tinygo build -target wasi -o ./dist/assembllm-openai-go.wasm main.go

test:
	extism call ./dist/assembllm-openai-go.wasm models --input "world" --wasi --log-level info
	@extism call ./dist/assembllm-openai-go.wasm completion --input "world" --wasi --allow-host "api.openai.com" --log-level info --set-config='{"api_key": "$(OPENAI_API_KEY)"}'