<script setup>
import Header from "./components/views/Header.vue";
import { RouterView } from "vue-router";
</script>

<template>
  <div id="app">
    <header>
      <Header />
    </header>
    <main>
      <router-view></router-view>
    </main>
  </div>
</template>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
}
</style>
