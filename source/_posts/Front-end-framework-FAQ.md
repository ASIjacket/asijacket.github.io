---
title: 前端框架常见开发问题 FAQ
author: LuckyStar
email: hasrimollony@gmail.com
toc: true
comments: true
readmore: false
hide: false
aplayer: false
hideTime: false
tags:
  - javascript
  - html
  - css
  - vue
  - react
categories:
  - 通用编程
date: 2020-11-21 22:28:21
updated: 2020-11-21 22:28:21
icon:
sticky:
type:
url:
description:
---





<!-- more -->

# 前端设计注意

- ### class单元拆分公共部分

- ### margin padding不应使用百分比 使用数字使用calc减去对应值

- ### vue 组件应该尽量拆分



# Box 定位

## div 垂直居中

```
display:flex;/*Flex布局*/

display: -webkit-flex; /* Safari */

align-items:center;/*指定垂直居中*/
```



## div水平居中

```
# 内div固定宽度 Flex
.out{
​    width: 300px;
​    height: 300px;
​    display: flex;
​    display: -webkit-flex;
​    justify-content: center;
​    align-items: center;
}

.out .in{
​    width: 100px;
​    height: 100px;
}


```



## 固定行宽 溢出隐藏

```
{
	width: calc(100% - 150px);
	overflow: hidden;
	height: 16px;
	display: inline-block;
	white-space: nowrap;
	text-overflow: ellipsis;
}
```



# 边框

## border 避免未设置类型而不显示

```
border-right:1px solid #F00;
```



## border的设置属性

| none    | 定义无边框。                                                 |
| ------- | ------------------------------------------------------------ |
| hidden  | 与 "none" 相同。不过应用于表时除外，对于表，hidden 用于解决边框冲突。 |
| dotted  | 定义点状边框。在大多数浏览器中呈现为实线。                   |
| dashed  | 定义虚线。在大多数浏览器中呈现为实线。                       |
| solid   | 定义实线。                                                   |
| double  | 定义双线。双线的宽度等于 border-width 的值。                 |
| groove  | 定义 3D 凹槽边框。其效果取决于 border-color 的值。           |
| ridge   | 定义 3D 垄状边框。其效果取决于 border-color 的值。           |
| inset   | 定义 3D inset 边框。其效果取决于 border-color 的值。         |
| outset  | 定义 3D outset 边框。其效果取决于 border-color 的值。        |
| inherit | 规定应该从父元素继承边框样式。                               |

## box对齐

- margin 外盒 影响对齐
  
- padding 内盒 不影响border 
  
- 设置为 box-sizing: border-box;
  
  

## 使用 JavaScript 函数添加 CSS 样式

- 使用变量 + 函数 + addEventListenerd 改变样式变量

- 使用函数 + addEventListener 直接return Style-String

​    

## vue
### Vue滚动条插件

vue-custom-scrollbar

```
npm install vue-custom-scrollbar
```



### CSS sprite 雪碧图 一图图标

` https://css.spritegen.com/`



### 缩放

```
transform: scale(.9);
```



### Vue 父元素向子元素传参


### Vue 子元素向父元素传参

父

```
<v-child @toChild_function='fatherFunction'>

fatherFunction(data){ this.x = data }
```



子

```
this.$emit('toChild_function', this.data)

react 引号嵌套变量 使用${}时外面使用反引号`
```



### i 标签 嵌套样式

```
<i style={{background:url(${require("../../../../assets/imgs/ico/InspectionArea.svg")})`}}
/>
```

 

###  Json 的key含有特殊符号的 取值处理

使用['key']取出

```
father['special.key'].son
```



### 控制页面滚动

scrollTo 

窗口滚动和块内滚动需要绑定不同参数

x , y 为滚动的像素 可以使用offsetTop获取对上一层的高度



```
window.scrollTo(x,y)

document.querySelector("body").scrollTo(x,y)

const myRef = useRef(null)
<div ref={myRef} style={{height:1000px}}>
<button onclick={()=>scrollToRef(myRef)}/>

const scrollToRef = (ref) => window.scrollTo(0, ref.current.offsetTop)  
const scrollToRef = (ref) => ref.current.scrollTo(0, ref.current.offsetTop)  //顶部
const scrollToRef = (ref) => ref.current.scrollTo(0, ref.current.clientHeight-220) 下移
```



### 当 setState 设置值后有时无法获取 无法执行下一步函数

- 使用useEffect监听
- 使用useRef

```
const[num, setNum] = (0)

​    

useEffect(() => {
​        getNum()
​    }, [num])

​    const getNum = () => {
​        const newStr = "现在数字是" + num
​        setStr(newStr)
​    }

​    
​    const main= () => {
​        setNum(num + 1)
​    }

const numRef = useRef(1)
const [num, setNum] = useState(numRef.current)
const [str, setStr] = useState("现在数字是1")

const getNum = () => {
​    const newStr = "现在数字是" + numRef.current
​    changeStr(newStr)
}

const main = () => {
​    numRef.current = num + 1
​    changeNum(numRef.current)
​    getNum()
}
```



### JSON 全局搜索

```
function searchExpertInput(searchKey: any) {
​    debugger
​    let eList = [...expertListPre]
​    let temp = []

​    if (searchKey.trim() !== "") {
​        for (let line of eList) {
​            let lineArr = line.dataMap
​            //行循环去重跳出标志位
​            let tflag = true
​            //循环行内参数
​            Object.keys(lineArr).forEach(k => {
​                if (tflag) {
​                    let v = lineArr[k]
​                    if (v.toString().trim() !== "" && v.toString().indexOf(searchKey) !== -1) {
​                        temp.push(line)
​                        tflag = false
​                    }
​                }
​            })
​        }
​    } else {
​        temp = [...expertListPre]
​    }

​    setExpertList(temp)
}
```



### useState 更新

useState放入同一个对象并不会重新渲染 

```
t = {...old}

tt = [...old]
```

