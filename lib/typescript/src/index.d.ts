import MsuCseV2 from './NativeMsuCseV2';
export declare function initialize(developmentMode?: boolean): void;
export declare function isValidCVV(cvv: string): boolean;
export declare function isValidCVVWithPan(cvv: string, pan: string): boolean;
export declare function isValidCardHolderName(name: string): boolean;
export declare function isValidPan(pan: string): boolean;
export declare function isValidCardToken(token: string): boolean;
export declare function isValidExpiry(month: number, year: number): boolean;
export declare function detectBrand(pan: string): string;
export declare function encryptCvv(cvv: string, nonce: string): Promise<string>;
export declare function encryptCard(pan: string, cardHolderName: string, expiryYear: number, expiryMonth: number, cvv: string, nonce: string): Promise<string>;
export declare function getErrors(): string[];
export declare function hasErrors(): boolean;
export type { Spec } from './NativeMsuCseV2';
export { MsuCseV2 };
//# sourceMappingURL=index.d.ts.map