import MsuCseV2 from './NativeMsuCseV2';

// Initialize CSE with development mode
export function initialize(developmentMode: boolean = false): void {
  return MsuCseV2.initialize(developmentMode);
}

// Validation methods
export function isValidCVV(cvv: string): boolean {
  return MsuCseV2.isValidCVV(cvv);
}

export function isValidCVVWithPan(cvv: string, pan: string): boolean {
  return MsuCseV2.isValidCVVWithPan(cvv, pan);
}

export function isValidCardHolderName(name: string): boolean {
  return MsuCseV2.isValidCardHolderName(name);
}

export function isValidPan(pan: string): boolean {
  return MsuCseV2.isValidPan(pan);
}

export function isValidCardToken(token: string): boolean {
  return MsuCseV2.isValidCardToken(token);
}

export function isValidExpiry(month: number, year: number): boolean {
  return MsuCseV2.isValidExpiry(month, year);
}

// Card brand detection
export function detectBrand(pan: string): string {
  return MsuCseV2.detectBrand(pan);
}

// Encryption methods (async)
export function encryptCvv(cvv: string, nonce: string): Promise<string> {
  return MsuCseV2.encryptCvv(cvv, nonce);
}

export function encryptCard(
  pan: string,
  cardHolderName: string,
  expiryYear: number,
  expiryMonth: number,
  cvv: string,
  nonce: string
): Promise<string> {
  return MsuCseV2.encryptCard(pan, cardHolderName, expiryYear, expiryMonth, cvv, nonce);
}

// Error handling
export function getErrors(): string[] {
  return MsuCseV2.getErrors();
}

export function hasErrors(): boolean {
  return MsuCseV2.hasErrors();
}

// Export types
export type { Spec } from './NativeMsuCseV2';

// Export the native module for advanced usage
export { MsuCseV2 };
