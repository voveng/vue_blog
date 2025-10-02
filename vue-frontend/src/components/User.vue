<script setup>
import { ref, onMounted } from 'vue';
import { useErrorHandler } from '../composables/useErrorHandler';

const user = ref(null);
const loading = ref(false);
const { errors, setError, clearErrors, hasErrors } = useErrorHandler();

const fetchUser = async () => {
  loading.value = true;
  clearErrors();
  
  try {
    const response = await fetch("http://localhost:3000/api/v1/profile/show");
    if (response.ok) {
      user.value = await response.json();
    } else {
      setError('profile', 'Failed to fetch user profile');
    }
  } catch (err) {
    setError('profile', err.message);
    console.error('Error fetching user:', err);
  } finally {
    loading.value = false;
  }
};

onMounted(() => {
  fetchUser();
});
</script>

<template>
  <div v-if="loading">Loading user profile...</div>
  <div v-else-if="hasErrors" class="error">
    <p>Error: {{ errors.profile && errors.profile[0] }}</p>
  </div>
  <div v-else-if="user">
    <h2>User Profile</h2>
    <p>Name: {{ user.name }}</p>
    <p>Email: {{ user.email }}</p>
  </div>
  <div v-else>
    <p>No user data available</p>
  </div>
</template>

<style scoped>
.error {
  color: red;
}
</style>
