<template>
  <div v-if="loading">Loading post...</div>
  <div v-else-if="post">
    <h1>{{ post.title }}</h1>
    <p>{{ post.body }}</p>
  </div>
  <div v-else-if="hasErrors" class="error">
    <p>Error: {{ errors.general && errors.general[0] || 'Post not found' }}</p>
  </div>
  <div v-else-if="!post && !loading">
    <p>Post not found</p>
  </div>
</template>

<script setup>
import { ref, onMounted, watch, computed } from "vue";
import { useRoute } from "vue-router";
import { postsService } from '../services/postsService';
import { useErrorHandler } from '../composables/useErrorHandler';

const route = useRoute();
const post = ref(null);
const loading = ref(false);
const { errors, setError, clearErrors, hasErrors } = useErrorHandler();

const fetchPost = async (id) => {
  console.log('Fetching post with ID:', id); // Отладочное сообщение
  loading.value = true;
  clearErrors();
  
  if (!id) {
    setError('general', 'No post ID provided');
    loading.value = false;
    return;
  }
  
  try {
    const result = await postsService.getById(id);
    console.log('Post fetch result:', result); // Отладочное сообщение
    
    if (result.success) {
      // API возвращает массив, где первый элемент содержит post и comments
      if (result.data && result.data[0] && result.data[0].post) {
        post.value = result.data[0].post;
        console.log('Post loaded:', result.data[0].post);
      } else {
        setError('general', 'Post data format is incorrect');
        post.value = null;
      }
    } else {
      setError('general', `Failed to fetch post: ${result.error || 'Server error'}`);
      console.error('Failed to fetch post:', result);
      post.value = null;
    }
  } catch (error) {
    setError('general', 'An unexpected error occurred while fetching post');
    console.error('Fetch post error:', error);
    post.value = null;
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  console.log('PostDetail mounted, route params:', route.params);
  fetchPost(route.params.id);
});

watch(
  () => route.params.id,
  (newId) => {
    console.log('Route ID changed:', newId);
    fetchPost(newId);
  },
);

const isPostLoading = computed(() => loading.value);
const hasPost = computed(() => !!post.value);
</script>
