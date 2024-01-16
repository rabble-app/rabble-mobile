//
//  applePay.swift
//  Runner
//
//  Created by Hatesh Kumar on 07/07/2023.
//

import Foundation
import PassKit
import Stripe

class ApplePayHandler {
    static func handleApplePayButtonTapped() {
        let merchantIdentifier = "merchant.com.your_app_name"
        let paymentRequest = StripeAPI.paymentRequest(withMerchantIdentifier: merchantIdentifier, country: "US", currency: "USD")

        // Configure the line items on the payment request
        paymentRequest.paymentSummaryItems = [
            // The final line should represent your company;
            // it'll be prepended with the word "Pay" (that is, "Pay iHats, Inc $50")
            PKPaymentSummaryItem(label: "iHats, Inc", amount: 50.00),
        ]

        // Continue with the implementation as needed
        // ...
    }
}
