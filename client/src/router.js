import Vue from 'vue'
import Router from 'vue-router'
import ProtoDapp from './components/ProtoDapp.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
//   base: process.env.BASE_URL,
  routes: [
      {
          path: '/',
          name: 'proto-dapp',
          component: ProtoDapp
      }
  ]
})
