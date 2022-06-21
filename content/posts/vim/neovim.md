+++
date = "2022-06-20T14:06:05-04:00"
title = "NeoVim is a modern life style"
+++

# Neovim outstanding configuration file

# My neovim simple configuration

- pure lua
- super fast
- intuitive

https://gitee.com/linuxing3/nvim

## 依赖

For newer version of neovim, use `snap` to install

```bash
sudo snap install neovim
sudo apt install -y ripgrep fd-find
```

## 构建

```bash
alias nvim=/snap/bin/nvim
nvim +PackerSync
nvim +Compile
```

## Workflow

1. Add a new blog

2. Editing

3. Saving

4. toggle float terminal with `<Space>tf`

5. Press `a` to add new file

6. Press `c` to commit

7. Press `P` to push

8. Wait for `github workflow` to generate blog

9. Visit blog at `https://linuxing3.github.io` and `http://localhost:1313`

## 参与贡献

## 翻译

## 授权协议

