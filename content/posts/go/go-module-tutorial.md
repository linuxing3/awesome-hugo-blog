+++
title="go module tutorial"
date="2020-02-05T14:05:34-04:00"
+++

# Go Module 工程模块化

## 创建一个叫`hello`的模块

目录`/home/gopher/hello`

```go
package hello
func Hello() string {
    return "Hello, world."
}
```

## `hello_test`测试文件

```go
package hello

import "testing"

func TestHello(t *testing.T) {
    want := "Hello, world."
    if got := Hello(); got != want {
        t.Errorf("Hello() = %q, want %q", got, want)
    }
}
```

测试一下
```sh
$ go test
PASS
ok  	_/home/gopher/hello	0.020s
$
```

## 初始化模块

```sh
go mod init example.com/hello
go test // 下载依赖并缓存
```

## 添加依赖

```go
package hello

import "rsc.io/quote"

func Hello() string {
    return quote.Hello()
}
```

## 下载依赖

```go
go test
go list -m all // 列出全部模块
go get golang.org/x/text // 单独升级一个依赖, 将依赖改为indirect
go list -m -versions rsc.io/sampler // 显示全部版本
go list -m rsc.io/q... // 显示各版本
go doc rsc.io/quote/v3 // 显示文档
go get rsc.io/sampler@v1.3.1
go mod tidy // 删除无用依赖
```

## 发布模块

```sh
go mod tidy
# a final time to make sure everything is working.
go test ./... 
git add go.mod go.sum hello.go hello_test.go
git commit -m "hello: changes for v1.0.0"
# git tag
git tag v1.0.0
git push origin v1.0.0
```

## 关于测试

- 文件名后面加上 `_test.go`。

- 文件中加上一个测试函数`TestXXX`, 签名为 `func (t *testing.T)`。 

- 如果出现`t.Error`或`t.Fail`，测试失败。

```go
package morestrings

import "testing"

func TestReverseRunes(t *testing.T) {
	cases := []struct {
		in, want string
	}{
		{"Hello, world", "dlrow ,olleH"},
		{"Hello, 世界", "界世 ,olleH"},
		{"", ""},
	}
	for _, c := range cases {
		got := ReverseRunes(c.in)
		if got != c.want {
			t.Errorf("ReverseRunes(%q) == %q, want %q", c.in, got, c.want)
		}
	}
}
```

# 总结

`go mod init` creates a new module, initializing the go.mod file that describes it.

`go build`, `go test`, and other package-building commands add new dependencies to go.mod as needed.

`go list -m all` prints the current module’s dependencies.

`go get` changes the required version of a dependency (or adds a new dependency).

`go mod tidy` removes unused dependencies.