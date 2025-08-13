import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  // Initialization
  initialize(developmentMode: boolean): void;

  // Validation methods
  isValidCVV(cvv: string): boolean;
  isValidCVVWithPan(cvv: string, pan: string): boolean;
  isValidCardHolderName(name: string): boolean;
  isValidPan(pan: string): boolean;
  isValidCardToken(token: string): boolean;
  isValidExpiry(month: number, year: number): boolean;

  // Card brand detection
  detectBrand(pan: string): string;

  // Encryption methods (async)
  encryptCvv(cvv: string, nonce: string): Promise<string>;
  encryptCard(
    pan: string,
    cardHolderName: string,
    expiryYear: number,
    expiryMonth: number,
    cvv: string,
    nonce: string
  ): Promise<string>;

  // Error handling
  getErrors(): string[];
  hasErrors(): boolean;
}

export default TurboModuleRegistry.getEnforcing<Spec>('MsuCseV2');
