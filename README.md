# MQ

## MQ is:
- a Swift package providing extensions for the language
- a foundation for writing code in certain style

## MQ is not:
- a place to put commonly used fragments of code
- a place to implement domain or platform specific solutions

MQ package has no dependencies besides Swift itself and its standard library. However it can conditionally provide extensions and functionalities on platforms where some platform specific (iOS/macOS etc.) libraries are available.

Preferred code style is described as a part of this repository.

## What is inside?

MQ is a library providing Swift language extensions. It includes:
- `SourceCodeLocation`, `SourceCodeMeta`, `SourceCodeContext` - tools for gathering metadata from the source code.
- `TheError` - base interface for errors and error handling with a bunch of common error implementations.
- `Lock` - abstraction over locking
- `void`, `always`, `noop` - placeholders for various of contexts.
- `runtimeAssert`, `runtimeAssertionFailure` - replacement for Swift assertions that can be manually controlled i.e. to allow unit test coverage for paths using assertions.

## License

Copyright 2021 Miquido

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.