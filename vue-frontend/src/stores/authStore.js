// src/stores/authStore.js
import { reactive, computed } from 'vue';
import { authService } from '../services/authService';

const state = reactive({
  user: null,
  token: localStorage.getItem('token') || null,
  loading: false,
  error: null,
});

const authStore = {
  // State
  state,

  // Getters
  isAuthenticated: computed(() => !!state.token),
  currentUser: computed(() => state.user),
  currentUserId: computed(() => state.user?.id),

  // Actions
  async login(credentials) {
    state.loading = true;
    state.error = null;
    
    try {
      const result = await authService.signIn(credentials);
      
      if (result.success) {
        // First, save the token
        state.token = result.data.token; 
        localStorage.setItem('token', result.data.token);
        
        // Now fetch user profile using the profile service
        // which will include the token in headers
        const profileModule = await import('../services/profileService');
        const profileResult = await profileModule.profileService.getProfile();
        
        if (profileResult.success) {
          state.user = profileResult.data;
        } else {
          console.error('Failed to fetch user profile:', profileResult.error);
        }
      } else {
        state.error = result.error;
      }
    } catch (error) {
      state.error = error.message;
    } finally {
      state.loading = false;
    }
  },

  logout() {
    state.token = null;
    state.user = null;
    localStorage.removeItem('token');
  },

  async signup(userData) {
    state.loading = true;
    state.error = null;
    
    try {
      const result = await authService.signUp(userData);
      
      if (result.success) {
        state.token = result.data.token; // API returns only token
        localStorage.setItem('token', result.data.token);
        
        // Fetch user profile to get user data after successful signup
        const profileModule = await import('../services/profileService');
        const profileResult = await profileModule.profileService.getProfile();
        
        if (profileResult.success) {
          state.user = profileResult.data;
        } else {
          console.error('Failed to fetch user profile:', profileResult.error);
        }
      } else {
        state.error = result.error;
      }
    } catch (error) {
      state.error = error.message;
    } finally {
      state.loading = false;
    }
  }
};

export default authStore;