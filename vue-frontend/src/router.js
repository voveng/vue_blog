import { createRouter, createWebHashHistory } from "vue-router";
import Posts from "./components/Posts.vue";
import Signup from "./components/views/Signup.vue";
import Signin from "./components/views/Signin.vue";
import PostDetail from "./components/PostDetail.vue";
export default createRouter({
  history: createWebHashHistory(),
  routes: [
    //{ path: "/posts", component: Posts },
    { path: "/posts/:id", component: PostDetail, props: true },
    { path: "/signup", component: Signup },
    { path: "/signin", component: Signin },
  ],
});
