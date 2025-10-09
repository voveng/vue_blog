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
    console.log('[AuthStore] Attempting login with:', credentials);
    state.loading = true;
    state.error = null;
    
    try {
      const result = await authService.signIn(credentials);
      console.log('[AuthStore] Received from signIn service:', result);
      
      if (result.success) {
        // First, save the token
        state.token = result.data.token; 
        localStorage.setItem('token', result.data.token);
        
        // Now fetch user profile using the profile service
        // which will include the token in headers
        const profileModule = await import('../services/profileService');
        const profileResult = await profileModule.profileService.getProfile();
        console.log('[AuthStore] Received from profile service:', profileResult);
        
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
    console.log('[AuthStore] Attempting signup with:', userData);
    state.loading = true;
    state.error = null;
    
    try {
      // First, create the user.
      const result = await authService.signUp(userData);
      console.log('[AuthStore] Received from signUp service:', result);

      if (result.success) {
        // After successful signup, perform a login to fetch user data and set the session correctly.
        console.log('[AuthStore] Signup successful, proceeding to login...');
        await this.login({ email: userData.email, password: userData.password });
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