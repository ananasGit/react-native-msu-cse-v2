import type { TurboModule } from 'react-native';
export interface Spec extends TurboModule {
    initialize(developmentMode: boolean): void;
    isValidCVV(cvv: string): boolean;
    isValidCVVWithPan(cvv: string, pan: string): boolean;
    isValidCardHolderName(name: string): boolean;
    isValidPan(pan: string): boolean;
    isValidCardToken(token: string): boolean;
    isValidExpiry(month: number, year: number): boolean;
    detectBrand(pan: string): string;
    encryptCvv(cvv: string, nonce: string): Promise<string>;
    encryptCard(pan: string, cardHolderName: string, expiryYear: number, expiryMonth: number, cvv: string, nonce: string): Promise<string>;
    getErrors(): string[];
    hasErrors(): boolean;
}
declare const _default: Spec;
export default _default;
//# sourceMappingURL=NativeMsuCseV2.d.ts.map