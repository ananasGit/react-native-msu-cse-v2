package com.msucsev2

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReadableArray
import com.facebook.react.bridge.WritableNativeArray
import com.facebook.react.module.annotations.ReactModule

@ReactModule(name = MsuCseV2Module.NAME)
class MsuCseV2Module(reactContext: ReactApplicationContext) :
  NativeMsuCseV2Spec(reactContext) {

  private var cse: CSE? = null

  override fun getName(): String {
    return NAME
  }

  // MARK: - Initialization

  override fun initialize(developmentMode: Boolean) {
    cse = CSE(developmentMode)
  }

  // MARK: - Validation Methods

  override fun isValidCVV(cvv: String): Boolean {
    return cse?.isValidCVV(cvv) ?: false
  }

  override fun isValidCVVWithPan(cvv: String, pan: String): Boolean {
    return cse?.isValidCVV(cvv, pan) ?: false
  }

  override fun isValidCardHolderName(name: String): Boolean {
    return cse?.isValidCardHolderName(name) ?: false
  }

  override fun isValidPan(pan: String): Boolean {
    return cse?.isValidPan(pan) ?: false
  }

  override fun isValidCardToken(token: String): Boolean {
    return cse?.isValidCardToken(token) ?: false
  }

  override fun isValidExpiry(month: Double, year: Double): Boolean {
    return cse?.isValidExpiry(month.toInt(), year.toInt()) ?: false
  }

  // MARK: - Card Brand Detection

  override fun detectBrand(pan: String): String {
    return cse?.detectBrand(pan)?.name ?: "UNKNOWN"
  }

  // MARK: - Encryption Methods (Async)

  override fun encryptCvv(cvv: String, nonce: String, promise: Promise) {
    val cseInstance = cse
    if (cseInstance == null) {
      promise.reject("CSE_NOT_INITIALIZED", "CSE not initialized. Call initialize() first.")
      return
    }

    cseInstance.encrypt(cvv, nonce, object : EncryptCallback {
      override fun onSuccess(encrypted: String) {
        promise.resolve(encrypted)
      }

      override fun onError(exception: EncryptException) {
        promise.reject("ENCRYPTION_ERROR", exception.message, exception)
      }
    })
  }

  override fun encryptCard(
    pan: String,
    cardHolderName: String,
    expiryYear: Double,
    expiryMonth: Double,
    cvv: String,
    nonce: String,
    promise: Promise
  ) {
    val cseInstance = cse
    if (cseInstance == null) {
      promise.reject("CSE_NOT_INITIALIZED", "CSE not initialized. Call initialize() first.")
      return
    }

    cseInstance.encrypt(
      pan,
      cardHolderName,
      expiryYear.toInt(),
      expiryMonth.toInt(),
      cvv,
      nonce,
      object : EncryptCallback {
        override fun onSuccess(encrypted: String) {
          promise.resolve(encrypted)
        }

        override fun onError(exception: EncryptException) {
          promise.reject("ENCRYPTION_ERROR", exception.message, exception)
        }
      }
    )
  }

  // MARK: - Error Handling

  override fun getErrors(): ReadableArray {
    val errors = cse?.errors ?: emptyList()
    val array = WritableNativeArray()
    for (error in errors) {
      array.pushString(error)
    }
    return array
  }

  override fun hasErrors(): Boolean {
    return cse?.hasErrors() ?: false
  }

  companion object {
    const val NAME = "MsuCseV2"
  }
}
