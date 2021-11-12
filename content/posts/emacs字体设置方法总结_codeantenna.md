+++
title = "Emacs字体设置方法总结 - CodeAntenna"
author = ["Xing Wenju"]
date = 2021-11-12T00:00:00-04:00
draft = false
+++

## <span class="timestamp-wrapper"><span class="timestamp">[2021-11-12 周五 11:13]</span></span> {#}

由于目前的状况是两种字体系统并存，我们安装字体时就必须同时照顾到两者。 有时候在网上我们会看到一些字体安装经验介绍，比如：“安装字体太简单了， 把字体丢到 ~/.fonts 下面，执行一下 fc-cache 命令，你就可以在 firefox 中 使用这个字体了。”实际上，这只是为 xft 字体系统安装字体的方法，按这种方 法安装的字体，采用核心字体系统的程序无法使用，也就是说 emacs 无法使用这 样安装的字体。

第一步，拷贝字体。选择一个目录，把想用的字体拷贝到这个目录下。比如：

```shell
cp simsun.ttf /path/to/my/truetype/font/simsun.ttf
```

第二步，生成 fonts.scale 与 fonts.dir 在你的字体目录下用 mkfontscale
命令生成 fonts.scale 文件，用 mkfontdir 命令生成 fonts.dir 文件，注意
命令的顺序不能颠倒，否则生成 的 fonts.dir 是空文件。其实这两个文件的内
容是一样的，因此也可以直接 cp fonts.scale fonts.dir

不知道是什么原因 mkfontscale/mkfontdir 命令生成的 fonts.scale 文件中 缺少对 gbk 字体的支持，因此需要手工编辑 fonts.scale，添加一行：

```shell
simsun.ttf -misc-simsun-medium-r-normal--0-0-0-0-p-0-gbk-0
```

如果你用的是不同的字体，这一行的内容可能不太一样，但需要注意的是必须要 加上一个以 gbk-0 结尾的行。同时，文件第一行的那个数字要加1。 fonts.dir文件也要进行相应的修改，使这两个文件保持一致。如果不进行这 一步，就无法使用 gbk 字体。

第三步，修改 /etc/X11/xorg.conf (如果你在用 XFree86, 那就修改 XF86Config-4):  找到 Section "Module", 加载 freetype 模块：  Section "Module" ...... Load "freetype" ...... EndSection  找到 Section "Files", 添加你的字体路径：  Section "Files" ...... FontPath "/path/to/my/truetype/font" ...... EndSection  最后重新启动 X，这时候用 xlsfonts 命令应该能看到你安装的字体。

> 注意，只 有 xlsfonts 列出的字体，emacs 才能使用。

由于 emacs 是个支持多语言的程序，它支持很多种字符集，而一种字体一般只覆 盖一个或几个字符集，因此只用一种字体是无法显示 emacs 支持的所有文字的。 因此在emacs中需要设置 fontset，也就是多种字体的集合，或者叫做字体集。  如果我们不指定 fontset, 那么 emacs 会使用默认的 fontset-default 来显示 字体。如果你觉得这种字体不好看，就需要自己定义 fontset。

定义 fontset 有 两种方式

一种是在 ~/.emacs 中使用 create-fontset-from-fontset-spec 函 数，

一种是在 ~/.Xdefaults 中定义资源。我们分别介绍这两种方法。

```shell
-adobe-courier-medium-r-normal--0-0-0-0-p-0-iso8859-1

-adobe-courier-medium-r-normal--14-*-*-*-p-*-fontset-courier
```

选定了字体就可以用 create-fontset-from-fontset-spec 函数定义 fontset 了，这个函数很简单，它的参数是个字符串：

```emacs-lisp

(create-fontset-from-fontset-spec (concat "-*-courier-medium-r-normal-*-14-*-*-*-*-*-fontset-courier," "chinese-gb2312:-*-simsun-medium-r-*-*-14-*-*-*-c-*-gb2312*-*," "mule-unicode-0100-24ff:-*-simsun-medium-r-*-*-14-*-*-*-c-*-iso10646*-*," "korean-ksc5601:-*-*-medium-r-*-*-14-*-*-*-*-*-ksc5601*-*," "chinese-cns11643-5:-*-simsun-medium-r-*-*-14-*-*-*-c-*-gbk*-*," "chinese-cns11643-6:-*-simsun-medium-r-*-*-14-*-*-*-c-*-gbk*-*," "chinese-cns11643-7:-*-simsun-medium-r-*-*-14-*-*-*-c-*-gbk*-*," "sjis:-*-medium-r-normal--14-*-jisx0208*-*"))
(set-default-font "fontset-courier")
```

另外，为了让 emacs 创建新的 frame 时 (C-x 5 系列命令) 采用我们指定的 fontset，还要进行下面的设置：

```emacs-lisp
(setq default-frame-alist (append '((font . "fontset-courier")) default-frame-alist))
```

```shell

Emacs.Fontset-0:-*-courier-medium-r-normal-*-14-*-*-*-*-*-fontset-courier,/ chinese-gb2312:-*-simsun-medium-r-*-*-14-*-*-*-c-*-*-*,/ mule-unicode-0100-24ff:-*-simsun-medium-r-*-*-14-*-*-*-c-*-iso10646*-*,/ korean-ksc5601:-*-*-medium-r-*-*-14-*-*-*-*-*-ksc5601*-*,/ chinese-cns11643-5:-*-simsun-medium-r-*-*-14-*-*-*-c-*-gbk*-*,/ chinese-cns11643-6:-*-simsun-medium-r-*-*-14-*-*-*-c-*-gbk*-*,/ chinese-cns11643-7:-*-simsun-medium-r-*-*-14-*-*-*-c-*-gbk*-*,/ sjis:-*-medium-r-normal--14-*-jisx0208*-*

```
