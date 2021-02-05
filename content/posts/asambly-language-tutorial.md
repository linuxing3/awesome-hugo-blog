---
title: "Asambly Language Tutorial"
date: 2021-02-05T08:31:52-04:00
draft: false
---

## 汇编

汇而编之，才是汇编。这是废话。

学汇编，是和计算机底层打交道。

开篇
#### 编程语言的发展

- 机器语言
由0和1组成

-汇编语言(Assembly Language)
用符号代替了0和1，比机器语言便于阅读和记忆

- 高级语言
C\C++\Java\Swift等，更接近人类自然语言

- 操作：将寄存器BX的内容送入寄存器AX

机器语言：1000100111011000
汇编语言：mov ax, bx
高级语言：ax = bx;

### 汇编语言的特点

可以直接访问、控制各种硬件设备，比如存储器、CPU等，能最大限度地发挥硬件的功能

汇编指令是机器指令的助记符,同机器指令一一对应。每一种CPU都有自己的机器指令集\汇编指令集，所以汇编语言不具备可移植性

知识点过多，开发者需要对CPU等硬件结构有所了解，不易于编写、调试、维护

不区分大小写，比如mov和MOV是一样的

### 进制理解是关键

#### 二进制


#### 十六进制


### 内存管理是难点

![寄存器](https://lvchenqiang.github.io/lvchenqiang.github.io/2019/03/31/%E6%B1%87%E7%BC%96%E7%AE%80%E4%BB%8B/Snip20190401_103.png)

![寄存器2](https://lvchenqiang.github.io/lvchenqiang.github.io/2019/03/31/%E6%B1%87%E7%BC%96%E7%AE%80%E4%BB%8B/Snip20190401_104.png)

址方式

![address](https://lvchenqiang.github.io/lvchenqiang.github.io/2019/03/31/%E6%B1%87%E7%BC%96%E7%AE%80%E4%BB%8B/Snip20190331_47.png)

寻址计算
![address calculating](https://lvchenqiang.github.io/lvchenqiang.github.io/2019/03/31/%E6%B1%87%E7%BC%96%E7%AE%80%E4%BB%8B/Snip20190331_48.png)

不同的寻址方式

![indexing](https://lvchenqiang.github.io/lvchenqiang.github.io/2019/03/31/%E6%B1%87%E7%BC%96%E7%AE%80%E4%BB%8B/Snip20190401_96.png)

![indexing2](https://lvchenqiang.github.io/lvchenqiang.github.io/2019/03/31/%E6%B1%87%E7%BC%96%E7%AE%80%E4%BB%8B/Snip20190401_97.png)

![register](https://lvchenqiang.github.io/lvchenqiang.github.io/2019/03/31/%E6%B1%87%E7%BC%96%E7%AE%80%E4%BB%8B/Snip20190331_55.png)

![register2](https://lvchenqiang.github.io/lvchenqiang.github.io/2019/03/31/%E6%B1%87%E7%BC%96%E7%AE%80%E4%BB%8B/register_01.png)

### 调用指令要艺术

```asm
assume cs:code ds:data ss:stack

; 栈段
stack segment
       db 100 dup(0)
stack ends

;数据段

data segment
    
      db 100 dup(0)
      string db 'Hello!$'
data ends


;代码段

code segment
start:
    ;手动设置ds, ss
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss, ax
    
    
    ; 业务逻辑
    call print   ;调用print标识的指令         
                
                
  
   
   ; 退出
   mov ah,4cH
   int 21h
     
; 用到才需要调用                                
print:
   ; 打印 (中断指令)     
   ; ds:dx告诉字符串打印地址 
   mov dx, offset string
   mov ah,9h
   int 21h
   
   ret  ;执行完该指令后 能够返回上次需要执行的下一条指令 即回到 call print 下一条指令              

code ends
```


### 文章参考

[汇编入门完全指北](https://lvchenqiang.github.io/2019/03/31/%E6%B1%87%E7%BC%96%E7%AE%80%E4%BB%8B/)
