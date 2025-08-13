import Foundation

@objc
public class CSEBridge: NSObject {
    
    private var cse: CSE?
    
    @objc
    public func initialize(developmentMode: Bool) {
        if #available(iOS 10.0, *) {
            cse = CSE(developmentMode: developmentMode)
        }
    }
    
    // MARK: - Validation Methods
    
    @objc
    public func isValidCVV(_ cvv: String) -> Bool {
        guard let cse = cse else { return false }
        return cse.isValidCVV(cvv)
    }
    
    @objc
    public func isValidCVVWithPan(cvv: String, pan: String) -> Bool {
        guard let cse = cse else { return false }
        return cse.isValidCVV(cvv: cvv, pan: pan)
    }
    
    @objc
    public func isValidCardHolderName(_ name: String) -> Bool {
        guard let cse = cse else { return false }
        return cse.isValidCardHolderName(name)
    }
    
    @objc
    public func isValidPan(_ pan: String) -> Bool {
        guard let cse = cse else { return false }
        return cse.isValidPan(pan)
    }
    
    @objc
    public func isValidCardToken(_ token: String) -> Bool {
        guard let cse = cse else { return false }
        return cse.isValidCardToken(token)
    }
    
    @objc
    public func isValidExpiry(month: Int, year: Int) -> Bool {
        guard let cse = cse else { return false }
        return cse.isValidExpiry(month: month, year: year)
    }
    
    // MARK: - Card Brand Detection
    
    @objc
    public func detectBrand(_ pan: String) -> String {
        guard let cse = cse else { return "UNKNOWN" }
        let brand = cse.detectBrand(pan)
        return brand.rawValue
    }
    
    // MARK: - Encryption Methods
    
    @objc
    public func encryptCvv(cvv: String, nonce: String, callback: @escaping (String?, String?) -> Void) {
        guard let cse = cse else { 
            callback(nil, "CSE not initialized")
            return 
        }
        
        cse.encrypt(cvv: cvv, nonce: nonce) { result in
            switch result {
            case .success(let encrypted):
                callback(encrypted, nil)
            case .error(let error):
                callback(nil, self.errorToString(error))
            }
        }
    }
    
    @objc
    public func encryptCard(pan: String, 
                           cardHolderName: String, 
                           expiryYear: Int, 
                           expiryMonth: Int, 
                           cvv: String, 
                           nonce: String, 
                           callback: @escaping (String?, String?) -> Void) {
        guard let cse = cse else { 
            callback(nil, "CSE not initialized")
            return 
        }
        
        cse.encrypt(pan: pan, 
                   cardHolderName: cardHolderName, 
                   expiryYear: expiryYear, 
                   expiryMonth: expiryMonth, 
                   cvv: cvv, 
                   nonce: nonce) { result in
            switch result {
            case .success(let encrypted):
                callback(encrypted, nil)
            case .error(let error):
                callback(nil, self.errorToString(error))
            }
        }
    }
    
    // MARK: - Error Handling
    
    @objc
    public func getErrors() -> [String] {
        guard let cse = cse else { return [] }
        return cse.errors
    }
    
    @objc
    public func hasErrors() -> Bool {
        guard let cse = cse else { return false }
        return cse.hasErrors
    }
    
    // MARK: - Private Helpers
    
    private func errorToString(_ error: EncryptionError) -> String {
        switch error {
        case .requestFailed:
            return "Request failed"
        case .validationFailed:
            return "Validation failed"
        case .publicKeyEncodingFailed(let message):
            return "Public key encoding failed: \(message)"
        case .encryptionFailed(let message):
            return "Encryption failed: \(message)"
        case .unknownException(let error):
            return "Unknown exception: \(error.localizedDescription)"
        }
    }
}