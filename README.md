# react-native-msu-cse-v2

React Native Turbo Module implementation of Payten MSU-CSE (Client-Side Encryption) library for secure payment card data encryption.

## Features

- 🔐 **Client-Side Encryption** - Encrypt sensitive payment data before transmission
- ✅ **Card Validation** - Validate PAN, CVV, expiry dates, and card holder names
- 🏷️ **Brand Detection** - Automatic card brand recognition (Visa, Mastercard, etc.)
- 📱 **Cross-Platform** - Works on both iOS and Android
- ⚡ **Turbo Module** - High-performance native implementation
- 🔒 **Secure** - RSA encryption with public key fetching

## Installation

```sh
npm install react-native-msu-cse-v2
```

For iOS, run:
```sh
cd ios && pod install
```

## Usage

### Initialize the Library

```js
import { initialize } from 'react-native-msu-cse-v2';

// Initialize once in your app (preferably in App.js)
initialize(true); // true for development mode, false for production
```

### Card Validation

```js
import { 
  isValidPan, 
  isValidCVV, 
  isValidExpiry, 
  isValidCardHolderName,
  detectBrand 
} from 'react-native-msu-cse-v2';

// Validate card number
const panValid = isValidPan('4111111111111111'); // true

// Validate CVV
const cvvValid = isValidCVV('123'); // true
const cvvValidWithPan = isValidCVVWithPan('123', '4111111111111111'); // true

// Validate expiry
const expiryValid = isValidExpiry(12, 2025); // true

// Validate card holder name
const nameValid = isValidCardHolderName('John Doe'); // true

// Detect card brand
const brand = detectBrand('4111111111111111'); // 'VISA'
```

### Encryption

```js
import { encryptCard, encryptCvv } from 'react-native-msu-cse-v2';

try {
  // Encrypt full card data
  const encryptedCard = await encryptCard(
    '4111111111111111', // PAN
    'John Doe',         // Card holder name
    2025,               // Expiry year
    12,                 // Expiry month
    '123',              // CVV
    'unique-nonce-123'  // Nonce for security
  );
  
  console.log('Encrypted card data:', encryptedCard);
  
  // Or encrypt just CVV
  const encryptedCvv = await encryptCvv('123', 'unique-nonce-456');
  console.log('Encrypted CVV:', encryptedCvv);
  
} catch (error) {
  console.error('Encryption failed:', error.message);
}
```

### Error Handling

```js
import { getErrors, hasErrors } from 'react-native-msu-cse-v2';

// Check if there are validation errors
if (hasErrors()) {
  const errors = getErrors();
  console.log('Validation errors:', errors);
  // Example: ['PAN_INVALID', 'CVV_INVALID']
}
```

## API Reference

### Initialization
- `initialize(developmentMode: boolean)` - Initialize the CSE library

### Validation Methods
- `isValidPan(pan: string): boolean` - Validate card number
- `isValidCVV(cvv: string): boolean` - Validate CVV
- `isValidCVVWithPan(cvv: string, pan: string): boolean` - Validate CVV with specific PAN
- `isValidCardHolderName(name: string): boolean` - Validate card holder name
- `isValidExpiry(month: number, year: number): boolean` - Validate expiry date
- `isValidCardToken(token: string): boolean` - Validate card token

### Card Brand Detection
- `detectBrand(pan: string): string` - Returns card brand (VISA, MASTERCARD, etc.)

### Encryption Methods (Async)
- `encryptCard(pan, cardHolderName, expiryYear, expiryMonth, cvv, nonce): Promise<string>`
- `encryptCvv(cvv: string, nonce: string): Promise<string>`

### Error Handling
- `getErrors(): string[]` - Get validation error messages
- `hasErrors(): boolean` - Check if there are validation errors

## Error Codes

Common validation error codes:
- `PAN_INVALID` - Invalid card number
- `CVV_INVALID` - Invalid CVV
- `EXPIRY_INVALID` - Invalid expiry date
- `CARD_HOLDER_NAME_INVALID` - Invalid card holder name
- `NONCE_MISSING_OR_INVALID` - Missing or invalid nonce

## Security Notes

- Always use HTTPS when transmitting encrypted data
- Generate unique nonces for each encryption operation
- Validate all card data before encryption
- Use production mode (`initialize(false)`) in production builds

## Contributing

- [Development workflow](CONTRIBUTING.md#development-workflow)
- [Sending a pull request](CONTRIBUTING.md#sending-a-pull-request)
- [Code of conduct](CODE_OF_CONDUCT.md)

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
