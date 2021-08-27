project = project
include $(project)/Makefile

go = PATH_TO_GO_ON_WINDOWS

all: web windows

web: clean_web
	mkdir -p $(project)/build/web
	cd $(project) && cp $$(go env GOROOT)/misc/wasm/wasm_exec.js build/web/ || :
	cd $(project) && GOOS=js GOARCH=wasm go build -o build/web/game.wasm .
	[ -f "$(project)/index.html" ] && cp $(project)/index.html $(project)/build/web/ || :

windows: clean_windows
	mkdir -p $(project)/build/windows
	cd $(project) && GOOS=windows GOARCH=amd64 go build -o build/windows/$(name).exe .

run: windows
	./$(project)/build/windows/$(name).exe

deploy: deploy_web deploy_windows

deploy_web: web
	cd $(project)/build/web && zip -9 -r $(name).zip .
	butler push $(project)/build/web/$(name).zip $(itchio):web

deploy_windows: windows
	cd $(project)/build/windows && zip -9 -r $(name).zip .
	butler push $(project)/build/windows/$(name).zip $(itchio):windows

clean: clean_web clean_windows

clean_web:
	rm -rf $(project)/build/web

clean_windows:
	rm -rf $(project)/build/windows

.PHONY: clean web windows all
