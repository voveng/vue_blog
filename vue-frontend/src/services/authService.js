import api from './api';

export const authService = {
  async signIn(credentials) {
    return await api.post('/sign_in', { user: credentials });
  },

  async signUp(userData) {
    return await api.post('/sign_up', { user: userData });
  }
};