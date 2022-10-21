---
title: Evernote 迁移 Notion 记录
author: LuckyStar
email: hasrimollony@gmail.com
toc: true
comments: true
readmore: false
hide: false
aplayer: false
hideTime: false
tags:
  - Notion
  - Evernote
categories:
  - 系统维护
date: 2022-06-11 00:41:34
updated: 2022-06-11 00:41:34
icon:
sticky:
type:
url:
description:
---


Evernote 迁移 Notion 的记录和随笔

<!-- more -->

## 笔记软件的选择

笔记软件一般都有很强的用户忠诚度，一旦用户开始记录他们的资料，笔记软件就开始积累用户的时间资本，让用户更换笔记软件的同时付出更高的成本。



因此笔记软件最初的选择应慎之又慎。



笔记软件的选择标准我总结为三点

- 完善的导出功能

- 便捷的历史版本管理

- 不错的书写体验

  

对于第一点常见的国产大厂软件都可以Pass了，基本堵死了正常导出的途径，只能通过一些旁门左道不完美的实现笔记的导出，入了这些坑，或许有一天你的笔记不再是你的。



其余两点在现在的 2022 年，基本都可以做到令人差强人意的程度，或许都已经达到了能用的程度。

## Why Notion

经济基础决定上层建筑，money决定屁股。Notion 目前在某宝可以以很低的价格拿到几十年的专业版预付费，这些是源于 Notion 的小公司支持计划，之前封锁了一批滥用之后，现在已经比较安全了。对比 Evernote，最后一批羊毛账号售寝之后价格水涨船高，已经有了充足的动机跳车。



此外 Notion 的设计理念确实标新立异，以至于模仿者雨后春笋，总有写 Youtuber 教大家使用 Notion，在我看来毫无必要花费时间去学习别人的用法，一个好的软件会引导用户发现他们的闪光点。



事不宜迟，逃离 Evernote。



## 所需工具

Evernote-backup

https://github.com/vzhd1701/evernote-backup

Enex2notion

https://github.com/vzhd1701/enex2notion



## 迁移步骤

### 安装

```bash
pip install evernote-backup
pip install enex2notion
```

### 创建 Evernote 数据库 并同步

这里会提示登陆

```bash
evernote-backup init-db
evernote-backup sync
```

### 导出数据库到 enex 文件

```bash
evernote-backup export ./o
```

### 迁移到 Notion

```bash
enex2notion --token *token_v2* --verbose --mode PAGE --add-meta --mode-webclips TXT --log ./log --done-file ./finish --root-page EverNote ./o
```

### enex2notion 参数

| token_v2      | 在网页版 Notion Cookie 中复制对应字段  |
| ------------- | -------------------------------------- |
| mode          | 导出模式 page 即正常的笔记             |
| add-meta      | 添加tab 日期                           |
| mode-webclips | 将剪藏转换TXT或PDF类型                 |
| done-file     | 记录已完成上传文件的 hash 实现断点续传 |
| root-page     | Notion 中保存位置                      |