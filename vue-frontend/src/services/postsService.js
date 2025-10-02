import api from './api';

export const postsService = {
  async getAll() {
    return await api.get('/posts');
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