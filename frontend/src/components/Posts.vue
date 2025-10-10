<script setup>
import { ref, onMounted, computed } from "vue";
import { postsService } from '../services/postsService';
import { useErrorHandler } from '../composables/useErrorHandler';
import authStore from '../stores/authStore';
import Pagination from './Pagination.vue';

const posts = ref([]);
const post_id = ref(0);
const newPost = ref({
  title: "",
  body: "",
});
const pagination = ref({
  current_page: 1,
  total_pages: 1,
  total_count: 0,
  per_page: 20,
  next_page: null,
  prev_page: null
});
const currentPage = ref(1);
const perPage = ref(20);

const { errors, setError, clearErrors, hasErrors } = useErrorHandler();

const fetchPosts = async (page = 1, perPageValue = 20) => {
  try {
    const result = await postsService.getAll(page, perPageValue);
    
    if (result.success) {
      posts.value = result.data.posts;
      pagination.value = result.data.pagination;
      currentPage.value = result.data.pagination.current_page;
    } else {
      setError('posts', 'Failed to fetch posts');
    }
  } catch (error) {
    setError('posts', 'Unexpected error occurred while fetching posts');
    console.error('Fetch posts error:', error);
  }
};

const changePage = (page) => {
  if (page && page !== currentPage.value) {
    fetchPosts(page, perPage.value);
  }
};

const createPost = async () => {
  clearErrors();
  
  // Check if user is authenticated before creating post
  if (!authStore.state.token) {
    setError('general', 'You must be logged in to create a post');
    return;
  }
  
  // If user data is not loaded yet, try to use token to make the request
  // The API service will include the token in the request which will provide user context
  if (!authStore.currentUserId.value) {
    console.log("User data not loaded yet, but using available token for request");
  }
  
  const result = await postsService.create({
    title: newPost.value.title,
    body: newPost.value.body,
    user_id: authStore.currentUserId.value, // Use current user's ID
  });

  if (!result.success) {
    if (result.details && result.details.errors) {
      Object.keys(result.details.errors).forEach((errorKey) => {
        setError(errorKey, result.details.errors[errorKey]);
      });
    } else {
      setError('general', 'Failed to create post');
    }
    return;
  }

  await fetchPosts(currentPage.value, perPage.value);
  newPost.value = { title: "", body: "" };
};

onMounted(async () => {
  await fetchPosts();
});

const currentPost = ref(null);
const showPost = async (id) => {
  try {
    const result = await postsService.getById(id);
    if (result.success) {
      currentPost.value = result.data;
      post_id.value = id;
    } else {
      setError('post', `Failed to fetch post with ID: ${id}`);
    }
  } catch (error) {
    setError('post', 'Unexpected error occurred while fetching post');
    console.error('Show post error:', error);
  }
};

// Computed properties for template
const postCount = computed(() => posts.value.length);
const hasNewPostContent = computed(() => 
  newPost.value.title.trim() !== '' || newPost.value.body.trim() !== ''
);
const currentUserId = computed(() => authStore.currentUserId.value);
const isAuthenticated = computed(() => authStore.isAuthenticated.value);
const isUserDataLoaded = computed(() => !!authStore.state.user);
</script>
<template>
  <h1>Posts</h1>
  
  <!-- Error display using the composable -->
  <div v-if="hasErrors" class="error-message">
    <div v-for="(errorList, field) in errors" :key="field" class="field-errors">
      <div v-for="(error, index) in errorList" :key="index" class="error-item">
        <strong>{{ field }}:</strong> {{ error }}
      </div>
    </div>
  </div>
  
  <div v-if="isAuthenticated" class="new-post">
    <div v-if="!isUserDataLoaded && authStore.state.token" class="loading-user">
      <p>Loading user data... You can still create posts.</p>
    </div>
    <input type="text" v-model="newPost.title" placeholder="new title" />
    <input type="text" v-model="newPost.body" placeholder="new body" />
    <button @click="createPost">Create Post</button>
  </div>
  <div v-else class="auth-prompt">
    <p>Please <router-link to="/signin">sign in</router-link> to create posts.</p>
  </div>
  
  <div class="posts">
    <div v-for="post in posts" :key="post.id">
      <h2 class="head">
        <router-link :to="`/posts/${post.id}`">{{ post.title }}</router-link>
      </h2>
      <p class="post-body">{{ post.body }}</p>
    </div>
  </div>
  
  <!-- Pagination component -->
  <Pagination 
    :pagination="pagination" 
    @page-changed="changePage" 
  />
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
