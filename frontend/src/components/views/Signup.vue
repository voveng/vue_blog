<script setup>
import { ref, computed } from 'vue';
import { useRouter } from 'vue-router';
import { authService } from '../../services/authService';
import { useErrorHandler } from '../../composables/useErrorHandler';
import authStore from '../../stores/authStore';

const router = useRouter();
const name = ref('');
const email = ref('');
const password = ref('');
const password_confirmation = ref('');
const { errors, setError, clearErrors, hasErrors } = useErrorHandler();

const isFormValid = computed(() => {
  return (
    name.value.trim() !== '' &&
    email.value.trim() !== '' &&
    password.value.trim() !== '' &&
    password.value === password_confirmation.value
  );
});

const createUser = async () => {
  clearErrors();

  if (password.value !== password_confirmation.value) {
    setError('password_confirmation', 'Passwords do not match');
    return;
  }

  await authStore.signup({
    name: name.value,
    email: email.value,
    password: password.value,
    password_confirmation: password_confirmation.value,
  });

  if (authStore.state.error) {
    setError('form', 'Failed to create user');
    setError('general', authStore.state.error);
  } else {
    router.push('/posts');
  }
};
</script>

<template>
  <h3 class="title">Sign up</h3>
  
  <div v-if="hasErrors" class="error-message">
    <div v-for="(errorList, field) in errors" :key="field" class="field-errors">
      <div v-for="(error, index) in errorList" :key="index" class="error-item">
        <strong>{{ field }}:</strong> {{ error }}
      </div>
    </div>
  </div>
  
  <div class="input">
    <input type="text" v-model="name" placeholder="name" class="input-text"><br>
    <input type="text" v-model="email" placeholder="email" class="input-text"><br>
    <input type="password" v-model="password" placeholder="password" class="input-text"><br>
    <input type="password" v-model="password_confirmation" placeholder="password confirmation" class="input-text"><br>
    <button @click="createUser" class="btn" :disabled="!isFormValid">Create</button>
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
