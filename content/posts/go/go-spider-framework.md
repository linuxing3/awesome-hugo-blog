---
title: "Go spider framework"
date: 2021-04-11T08:31:52-04:00
draft: false
---



# Go爬虫框架

## 简洁明了的用户界面

使用cobra构建命令行基本程序

## chromedp

调用`chrome`的`Api`后台访问网页

因为`vps`服务器上没有安装`chrome`，所以我们可以使用`docker`的镜像来调用

### `docker-compose.yml`文件

```yml
version: '3'
services:
  db:
    image: postgres
    container_name: db
    restart: always
    ports: 
      - 5432:5432
    environment:
      - POSTGRES_USER=spider
      - POSTGRES_PASSWORD=20090909
      - POSTGRES_DB=spider
    volumes:
      - postgres-data:/var/lib/postgresql/data/ 
  adminer:
    image: adminer
    container_name: adminer
    links:
      - db
    restart: always
    environment:
      - POSTGRES_HOST=db
      - POSTGRES_PORT=5432
      - POSTGRES_USER=spider
      - POSTGRES_PASSWORD=20090909
      - POSTGRES_DB=spider
    ports:
      - 9433:8080
  spider:
    image: chromedp/headless-shell:latest
    container_name: spider
    depends_on:
      - db
    links:
      - db
    restart: always
    ports:
      - 9222:9222
    environment:
      - POSTGRES_HOST=db
      - POSTGRES_PORT=5432
      - POSTGRES_USER=spider
      - POSTGRES_PASSWORD=20090909
      - POSTGRES_DB=spider
    volumes:
      - /root/go/bin:/root/go/bin
      - ./crontab_job:/etc/cron.d/container_cronjob
    command:
      - chmod 644 /etc/cron.d/container_cronjob && cron

volumes:
  postgres-data: 

```

运行命令`docker-compose -up`将启动

![docker chrome spider](./docs/assets/docker-chrome-spider.png]

## goquery

查询页面元素

## go prisma

### `prisma.schema`文件

```sh
generator db {
  provider = "go run github.com/prisma/prisma-client-go"
}

datasource db {
  provider = "postgresql"
  url      = "postgresql://spider:20090909@db:5432/spider?schema=public" 
}

model movies {
  id          Int      @id @default(autoincrement())
  title       String?
  subtitle    String?
  other       String?
  desc        String?
  year        String?
  area        String?
  tag         String?
  star        String?
  comment     String?
  quote       String?
  created_at  DateTime @default(now())
  updated_at  DateTime @default(now())
}
```

### 使用`prisma`的`go`语言客户端，更优于使用`gorm`等框架

```bash
go run github.com/prisma/prisma-client-go generate
```

### 设置环境参数

1. 如果的vps中运行，修改hosts文件，将db指向`127.0.0.1`主机

2. 如果在docker中运行，修改docker-compose.yml文件，指向`db`容器


## 使用`deno`初始化数据库

echo "postgresql://spider:20090909@db:5432/spider?schema=public"

```bash
deno run -A --unstable https://raw.githubusercontent.com/linuxing3/gospider/main/create_table.ts"
```

## 使用`go admin`构建前端界面

```bash
go install github.com/GoAdminGroup/go-admin/adm
```