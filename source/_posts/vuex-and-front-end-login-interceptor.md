---
title: Vuex 与 前端登录拦截器
author: LuckyStar
email: hasrimollony@gmail.com
toc: true
comments: true
readmore: false
hide: false
aplayer: false
hideTime: false
tags:
  - web
  - vue
  - vuex
  - 前端
categories:
  - 通用编程
date: 2020-03-11 00:40:22
updated: 2020-03-11 00:40:22
icon:
sticky:
type:
url:
description:
---





<!-- more -->

首先要明确，登录状态应该被视为一个**全局属性，**避免在各个组件间的重复传参。



Vuex，它是专门为 Vue 开发的状态管理方案，我们可以把需要在各个组件中传递使用的变量、方法定义在这里，正好满足需要。



## 引入 Vuex

```
npm install vuex --save
```



src 目录下新建一个文件夹 store\index.js



```vue
import Vue from 'vue' 
import Vuex from 'vuex' 
Vue.use(Vuex)
```



index.js 里设置我们需要的状态变量和方法。

localStorage，即本地存储



```vue
export default new Vuex.Store({

  state: {

​    user: {
​      username: window.localStorage.getItem('user' || '[]') == null ? '' : JSON.parse(window.localStorage.getItem('user' || '[]')).username
​    }
  },

  mutations: {
​    login (state, user) {
​      state.user = user
​      window.localStorage.setItem('user', JSON.stringify(user))
​    }
  }

})
```



## 修改路由配置

src\router\index.js

拦截的路由添加 **requireAuth** 字段 以区分拦截

```vue
{
  path: '/index',
  name: 'AppIndex',
  component: AppIndex,

  meta: {
​    requireAuth: true
  }
}
```



## 使用钩子函数判断是否拦截

router.beforeEach()， 在访问每一个路由前调用



src\main.js 添加对 store 的引用

```
import store from './store'
```



## router后添加store

添加beforeEach() 函数

```vue
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'

var axios = require('axios')
axios.defaults.baseURL = 'http://localhost:8443/api'
Vue.prototype.$axios = axios
Vue.config.productionTip = false
Vue.use(ElementUI)

router.beforeEach((to, from, next) => {
​    if (to.meta.requireAuth) {
​      if (store.state.user.username) {
​        next()
​      } else {
​        next({
​          path: 'login',
​          query: {redirect: to.fullPath}
​        })
​      }
​    } else {
​      next()
​    }
  }
)

/* eslint-disable no-new */

new Vue({
  el: '#app',
  render: h => h(App),
  router,
  store,
  components: { App },
  template: '<App/>'
})
```



##  修改 Login.vue

返回的成功代码时，触发 store 中的 login() 方法，把 loginForm 对象传递给 store 中的 user 对象



也可以 获得 user 表的完整信息，比如用户昵称、用户级别等，返回前端，并传递给 user



获取登录前页面的路径并跳转，如果该路径不存在，则跳转到首页

```
login () {
  var _this = this
  console.log(this.$store.state)
  this.$axios

​    .post('/login', {
​      username: this.loginForm.username,
​      password: this.loginForm.password
​    })

​    .then(successResponse => {
​      if (successResponse.data.code === 200) {
​        // var data = this.loginForm
​        _this.$store.commit('login', _this.loginForm)
​        var path = this.$route.query.redirect
​        this.$router.replace({path: path === '/' || path === undefined ? '/index' : path})
​      }
​    })

​    .catch(failResponse => {

​    })

}
```

