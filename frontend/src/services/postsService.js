import api from './api';

export const postsService = {
  async getAll(page = 1, perPage = 20, userId = null, search = null) {
    const params = new URLSearchParams();
    params.append('page', page);
    params.append('per_page', perPage);
    
    if (userId) params.append('user_id', userId);
    if (search) params.append('search', search);
    
    return await api.get(`/posts?${params}`);
  },

  async getById(id) {
    return await api.get(`/posts/${id}`);
  },

  async create(postData) {
    return await api.post('/posts', { post: postData });
  },

  async update(id, postData) {
    return await api.put(`/posts/${id}`, { post: postData });
  },

  async delete(id) {
    return await api.delete(`/posts/${id}`);
  }
};