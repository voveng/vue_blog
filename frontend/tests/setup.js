// tests/setup.js
import { config } from '@vue/test-utils';

// Mock the $t function for Vue I18n if needed
config.global.mocks = {
  $t: (msg) => msg,
};