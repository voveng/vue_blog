<template>
  <div class="pagination-container">
    <div class="pagination-info">
      Showing {{ startIndex }} - {{ endIndex }} of {{ total }}
    </div>

    <ul class="pagination">
      <li :class="{ disabled: !pagination.prev_page }">
        <button
          @click="changePage(pagination.prev_page)"
          :disabled="!pagination.prev_page"
        >
          &laquo; Prev
        </button>
      </li>

      <li
        v-if="startPage > 1"
        @click="changePage(1)"
        :class="{ active: currentPage === 1 }"
      >
        <button>1</button>
      </li>

      <li v-if="startPage > 2" class="ellipsis">...</li>

      <li
        v-for="page in pageNumbers"
        :key="page"
        :class="{ active: currentPage === page }"
      >
        <button @click="changePage(page)">{{ page }}</button>
      </li>

      <li v-if="endPage < pagination.total_pages - 1" class="ellipsis">...</li>

      <li
        v-if="endPage < pagination.total_pages"
        :class="{ active: currentPage === pagination.total_pages }"
      >
        <button @click="changePage(pagination.total_pages)">
          {{ pagination.total_pages }}
        </button>
      </li>

      <li :class="{ disabled: !pagination.next_page }">
        <button
          @click="changePage(pagination.next_page)"
          :disabled="!pagination.next_page"
        >
          Next &raquo;
        </button>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "Pagination",
  props: {
    pagination: {
      type: Object,
      required: true,
    },
  },
  computed: {
    currentPage() {
      return this.pagination.current_page || 1;
    },
    total() {
      return this.pagination.total_count || 0;
    },
    perPage() {
      return this.pagination.per_page || 20;
    },
    startIndex() {
      return (this.currentPage - 1) * this.perPage + 1;
    },
    endIndex() {
      return Math.min(this.currentPage * this.perPage, this.total);
    },
    startPage() {
      return Math.max(1, this.currentPage - 2);
    },
    endPage() {
      return Math.min(this.pagination.total_pages, this.currentPage + 2);
    },
    pageNumbers() {
      const pages = [];
      for (let i = this.startPage; i <= this.endPage; i++) {
        pages.push(i);
      }
      return pages;
    },
  },
  methods: {
    changePage(page) {
      if (page && page !== this.currentPage) {
        this.$emit("page-changed", page);
      }
    },
  },
};
</script>

<style scoped>
.pagination-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 20px 0;
  padding: 0 20px;
}

.pagination-info {
  color: #666;
  font-size: 14px;
}

.pagination {
  display: flex;
  list-style: none;
  padding: 0;
  margin: 0;
}

.pagination li {
  margin: 0 2px;
}

.pagination li button {
  padding: 8px 12px;
  border: 1px solid #ddd;
  background: white;
  cursor: pointer;
  border-radius: 4px;
}

.pagination li button:hover:not(:disabled) {
  background: #f5f5f5;
}

.pagination li.active button {
  background: #007bff;
  color: white;
  border-color: #007bff;
}

.pagination li.disabled button {
  color: #ccc;
  cursor: not-allowed;
}

.pagination li.ellipsis button {
  border: none;
  background: transparent;
  cursor: default;
  padding: 8px 4px;
}

.pagination li.ellipsis {
  display: flex;
  align-items: center;
}
</style>

