<script setup>
  import { ref } from 'vue'
  const email =ref ('')
  const password =ref ('')

  const SignInURL = 'http://localhost:3000/api/v1/sign_in'
  const signIn = async() =>{
    const res = await fetch(SignInURL, {
      method : 'POST',
      headers : {'Content-Type' : 'application/json'},
      body : JSON.stringify({user:{
        email: email.value,
        password: password.value,
      }})
  })}
</script>
<template>
  <h3 class="title">Sign in</h3>
  <div class="input">
    <input type="text" v-model="email" placeholder="email" class="input-text"><br>
    <input type="text" v-model="password" placeholder="password" class="input-text"><br>
    <button @click="signIn" class="btn">Sign in</button>
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
</style>
