<template>
  <div v-if="post">
    <h1>{{ post.title }}</h1>
    <p>{{ post.body }}</p>
  </div>
  <div v-else>
    <p>Загрузка поста...</p>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";
import { useRoute } from "vue-router";

const route = useRoute();
const post = ref(null);
const postsUrl = "http://localhost:3000/api/v1/posts";

const fetchPost = async (id) => {
  const res = await fetch(`${postsUrl}/${id}`);
  post.value = await res.json();
  console.log(post.value);
};

onMounted(() => {
  fetchPost(route.params.id);
});

// Если в одном и том же компоненте меняется id в URL, подгружаем новый пост:
watch(
  () => route.params.id,
  (newId) => {
    fetchPost(newId);
  },
);
</script>
