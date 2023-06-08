<script setup>
</script>
<template>
  <div class="container header">
    <div class="text"><a href="#/signin">Sign in</a>| <a href="#/signup">Signup</a></div>
  </div>
</template>

<style scoped>
.header {
  display:block;
  width:100%;
  height: 30px;
  color: rgb(223, 238, 13);
  margin-bottom: 200;
  background-color: black;
  text-align: right;
  border-radius: 10px;

}
.container {
  width: 100%;
  max-width: 1470px;
  margin: 0 auto;
}

.text{
  padding: 5px;
  vertical-align: middle;
  display: inline-block;
  margin-right: 10px;
}

a{
  color: white;
}
</style>
