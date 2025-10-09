// src/composables/useErrorHandler.js
import { reactive, computed } from 'vue';

export function useErrorHandler() {
  const errors = reactive({});
  
  const setError = (field, message) => {
    if (!errors[field]) {
      errors[field] = [];
    }
    
    // Accept both string and array of messages
    const messages = Array.isArray(message) ? message : [message];
    errors[field].push(...messages);
  };

  const clearErrors = (field = null) => {
    if (field) {
      errors[field] = [];
    } else {
      Object.keys(errors).forEach(key => {
        errors[key] = [];
      });
    }
  };

  const hasErrors = computed(() => {
    return Object.keys(errors).some(field => errors[field].length > 0);
  });

  const getFieldErrors = (field) => {
    return errors[field] || [];
  };

  return {
    errors,
    setError,
    clearErrors,
    hasErrors,
    getFieldErrors
  };
}