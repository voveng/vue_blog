import { describe, it, expect } from 'vitest';
import { mount } from '@vue/test-utils';
import { createRouter, createWebHistory } from 'vue-router';
import App from '@/App.vue';

// Mock routes
const routes = [
  { path: '/', component: { template: '<div>Home</div>' } },
  { path: '/posts', component: { template: '<div>Posts</div>' } },
  { path: '/post/:id', component: { template: '<div>Post</div>' } },
  { path: '/profile', component: { template: '<div>Profile</div>' } },
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

describe('App.vue', () => {
  it('renders properly', async () => {
    const wrapper = mount(App, {
      global: {
        plugins: [router]
      }
    });
    
    expect(wrapper.exists()).toBe(true);
  });
});