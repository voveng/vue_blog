import { createRouter, createWebHashHistory } from 'vue-router'
import Posts from './components/Posts.vue';
import Signup from './components/views/Signup.vue';


export default createRouter({
  history: createWebHashHistory(),
  routes: [
      // { path: '/posts', component: Posts },
      { path: '/signup', component: Signup },
    ]
})
