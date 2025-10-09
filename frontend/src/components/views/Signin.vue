<script setup>
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import { authService } from '../../services/authService';
import { useErrorHandler } from '../../composables/useErrorHandler';
import authStore from '../../stores/authStore';

const router = useRouter();
const email = ref('');
const password = ref('');
const { errors, setError, clearErrors, hasErrors, getFieldErrors } = useErrorHandler();

const isLoginValid = computed(() => 
  email.value.trim() !== '' && password.value.trim() !== ''
);

const signIn = async () => {
  clearErrors();
  
  if (!isLoginValid.value) {
    setError('form', 'Please fill in all fields');
    return;
  }

  await authStore.login({
    email: email.value,
    password: password.value,
  });

  if (!authStore.state.error) {
    // Redirect to posts or dashboard after successful login
    router.push('/posts');
  } else {
    setError('credentials', 'Invalid email or password');
  }
};
</script>

<template>
  <h3 class="title">Sign in</h3>
  
  <div v-if="hasErrors" class="error-message">
    <div v-for="(errorList, field) in errors" :key="field" class="field-errors">
      <div v-for="(error, index) in errorList" :key="index" class="error-item">
        <strong v-if="field !== 'general'">{{ field }}:</strong> {{ error }}
      </div>
    </div>
  </div>
  
  <div class="input">
    <input type="text" v-model="email" placeholder="email" class="input-text"><br>
    <input type="password" v-model="password" placeholder="password" class="input-text"><br>
    <button @click="signIn" class="btn" :disabled="!isLoginValid">Sign in</button>
  </div>
</template>

<style scoped>
.input {
  text-align: center;
}

.input-text{
  margin-top: 10px;
  border-radius: 10px;
  border: 1px solid #3906f1;
}

.btn{
  background-color: rgb(45, 235, 7);
  color: blue;
  margin-top: 10px;
  border-radius: 10px;
}
.title{
  text-align: center;
  color: #07a3eb;
}

.error-message {
  color: red;
  margin: 10px 0;
}
.error-item {
  margin-bottom: 5px;
}
</style>
