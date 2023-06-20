<script setup>
  import { ref, onMounted } from 'vue';
  const posts = ref([])
  const post_id = ref(0)
  const postsUrl = 'http://localhost:3000/api/v1/posts';
  onMounted(async() => {
    posts.value = await fetch(postsUrl).then((res) =>res.json())
  })
</script>
<template>
  <div class="posts">
    <div v-for="post in posts" :key="post.id">
      <h2 class="head"><a class="body" href="#">{{ post.title }}</a></h2>
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
</style>
