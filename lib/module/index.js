"use strict";

import MsuCseV2 from "./NativeMsuCseV2.js";

// Initialize CSE with development mode
export function initialize(developmentMode = false) {
  return MsuCseV2.initialize(developmentMode);
}

// Validation methods
export function isValidCVV(cvv) {
  return MsuCseV2.isValidCVV(cvv);
}
export function isValidCVVWithPan(cvv, pan) {
  return MsuCseV2.isValidCVVWithPan(cvv, pan);
}
export function isValidCardHolderName(name) {
  return MsuCseV2.isValidCardHolderName(name);
}
export function isValidPan(pan) {
  return MsuCseV2.isValidPan(pan);
}
export function isValidCardToken(token) {
  return MsuCseV2.isValidCardToken(token);
}
export function isValidExpiry(month, year) {
  return MsuCseV2.isValidExpiry(month, year);
}

// Card brand detection
export function detectBrand(pan) {
  return MsuCseV2.detectBrand(pan);
}

// Encryption methods (async)
export function encryptCvv(cvv, nonce) {
  return MsuCseV2.encryptCvv(cvv, nonce);
}
export function encryptCard(pan, cardHolderName, expiryYear, expiryMonth, cvv, nonce) {
  return MsuCseV2.encryptCard(pan, cardHolderName, expiryYear, expiryMonth, cvv, nonce);
}

// Error handling
export function getErrors() {
  return MsuCseV2.getErrors();
}
export function hasErrors() {
  return MsuCseV2.hasErrors();
}

// Export types

// Export the native module for advanced usage
export { MsuCseV2 };
//# sourceMappingURL=index.js.map