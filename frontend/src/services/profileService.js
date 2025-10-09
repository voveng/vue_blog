import api from './api';

export const profileService = {
  async getProfile() {
    return await api.get('/profile/show');
  }
};