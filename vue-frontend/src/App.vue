<script setup>
import Header from './components/views/Header.vue';
import Posts from './components/Posts.vue'
</script>

<template>
<header>
  <Header />
</header>
<router-view></router-view>
  <Posts />
</template>

<style >

</style>
