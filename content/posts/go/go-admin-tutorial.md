---
title: "Goadmin Tutorial"
date: 2021-02-11T08:31:52-04:00
draft: false
---

## Go admin 

Goadmin是一个帮助你自动生成代码的辅助框架，很方便地可以根据后台数据库的数据结构，生成想要的前端代码。

### 安装

```bash
adm new -l cn 
```

### 使用

1. 下载sql的配置文件，导入到数据库中

2. 自动生成代码

```bash
adm generate -l cn -c admin.ini
```

