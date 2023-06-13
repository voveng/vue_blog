<script setup>
  import { ref } from 'vue'
  const name =ref ('')
  const email =ref ('')
  const password =ref ('')
  const password_confirmation =ref ('')

  const SignUpURL = 'http://localhost:3000/api/v1/sign_up'
  const createUser = async() =>{
    const res = await fetch(SignUpURL, {
      method : 'POST',
      headers : {'Content-Type' : 'application/json'},
      body : JSON.stringify({user:{
        name: name.value,
        email: email.value,
        password: password.value,
        password_confirmation: password_confirmation.value,
      }})
  })
  if (res.status === 201) {
    name.value = ''
    email.value = ''
    password.value = ''
    password_confirmation.value = ''
  }
  }
</script>
<template>
  <h3 class="title">Sign up</h3>
  <div class="input">
    <input type="text" v-model="name" placeholder="name" class="input-text"><br>
    <input type="text" v-model="email" placeholder="email" class="input-text"><br>
    <input type="text" v-model="password" placeholder="password" class="input-text"><br>
    <input type="text" v-model="password_confirmation" placeholder="password confirmation" class="input-text"><br>
    <button @click="createUser" class="btn">Create</button>
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
