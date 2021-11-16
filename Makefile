SHELL = sh
.ONESHELL:
.SHELLFLAGS = -e

build:
	swift build

clean:
	swift package reset

lint:
	swift run --configuration release --package-path ./FormatTool --build-path ./.toolsCache -- swift-format lint --configuration ./FormatTool/formatterConfig.json --parallel --recursive ./Package.swift ./Sources

format:
	swift run --configuration release --package-path ./FormatTool --build-path ./.toolsCache -- swift-format format --configuration ./FormatTool/formatterConfig.json --parallel --recursive ./Package.swift ./Sources --in-place
