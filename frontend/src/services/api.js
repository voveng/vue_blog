const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || "/api/v1";

class ApiService {
  constructor(baseURL) {
    this.baseURL = baseURL;
  }

  getAuthHeaders() {
    // Get token from localStorage at the moment of request
    // This ensures we always use the most recent token
    const token = localStorage.getItem('token');
    const headers = {
      "Content-Type": "application/json",
    };
    
    // Add authorization header if token exists
    if (token) {
      headers["Authorization"] = `Bearer ${token}`;
      console.log('Sending authorization token:', token.substring(0, 20) + '...'); // Log first 20 chars for debug
    } else {
      console.log('No token found in localStorage');
    }
    
    return headers;
  }

  async request(endpoint, options = {}) {
    const url = `${this.baseURL}${endpoint}`;
    
    const config = {
      headers: {
        ...this.getAuthHeaders(),
        ...options.headers,
      },
      ...options,
    };

    try {
      const response = await fetch(url, config);
      
      // Handle different response types based on content type
      const contentType = response.headers.get("content-type");
      let data;
      
      if (contentType && contentType.includes("application/json")) {
        data = await response.json();
      } else {
        data = await response.text();
      }

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`, {
          cause: { response, data }
        });
      }

      return { success: true, data };
    } catch (error) {
      if (error.cause) {
        return { 
          success: false, 
          error: error.message,
          details: error.cause.data
        };
      }
      return { success: false, error: error.message };
    }
  }

  get(endpoint) {
    return this.request(endpoint);
  }

  post(endpoint, data) {
    return this.request(endpoint, {
      method: "POST",
      body: JSON.stringify(data),
    });
  }

  put(endpoint, data) {
    return this.request(endpoint, {
      method: "PUT",
      body: JSON.stringify(data),
    });
  }

  delete(endpoint) {
    return this.request(endpoint, {
      method: "DELETE",
    });
  }
}

export default new ApiService(API_BASE_URL);