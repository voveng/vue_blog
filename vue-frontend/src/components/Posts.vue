<script setup>
import { ref, onMounted } from "vue";
const posts = ref([]);
const post_id = ref(0);
const postsUrl = "http://localhost:3000/api/v1/posts";
const newPost = ref({
  title: "",
  body: "",
});

const fetchPosts = async () => {
  posts.value = await fetch(postsUrl).then((res) => res.json());
};
const postErrors = ref({
  title: [],
  body: [],
});
const createPost = async () => {
  postErrors.value.title = [];
  postErrors.value.body = [];
  try {
    const res = await fetch(postsUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        post: {
          title: newPost.value.title,
          body: newPost.value.body,
          user_id: 1,
        },
      }),
    });
    if (!res.ok) {
      const errorData = await res.json();
      Object.keys(errorData.errors).forEach((errorKey) => {
        postErrors.value[errorKey] = errorData.errors[errorKey];
      });
      return;
    }
  } catch (error) {}
  await fetchPosts();
  newPost.value.title = "";
  newPost.value.body = "";
};
onMounted(async () => {
  await fetchPosts();
});
const currentPost = ref(null);
const showPost = async (id) => {
  const response = await fetch(`${postsUrl}/${id}`);
  const data = await response.json();
  currentPost.value = data;
  post_id.value = id;
};
</script>
<template>
  <h1>Posts</h1>
  <div v-if="postErrors" class="error-message">
    <ul>
      <li v-for="(error, index) in postErrors" :key="index">
        {{ error.messages }}
      </li>
    </ul>
  </div>
  <div class="new-post">
    <input type="text" v-model="newPost.title" placeholder="new title" />
    <input type="text" v-model="newPost.body" placeholder="new body" />

    <button @click="createPost">Create Post</button>
  </div>
  <div class="posts">
    <div v-for="post in posts" :key="post.id">
      <h2 class="head">
        <router-link :to="`/posts/${post.id}`">{{ post.title }}</router-link>
      </h2>
      <p class="post-body">{{ post.body }}</p>
    </div>
  </div>
</template>

<style scoped>
.head {
  color: red;
  text-align-last: left;
  margin-left: 30px;
}
.post-body {
  color: blue;
  text-align-last: left;
  margin-left: 50px;
}
.new-post {
  display: flex;
  text-align: center;
  margin-top: 20px;
  border-radius: 10px;
  flex-direction: column;
  gap: 10px;
  max-width: 500px;
}
.error-message {
  color: red;
}
</style>
