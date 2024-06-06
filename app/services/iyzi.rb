class Iyzi
  attr_accessor :amount

  def initialize(amount)
    @amount = amount 
  end

  def process
    {
      "status": "success",
      "locale": "en",
      "systemTime": 1686413012592,
      "conversationId": "devPayUiyzico",
      "price": @amount,
      "paidPrice": @amount,
      "installment": 1,
      "paymentId": "19682125",
      "fraudStatus": 1,
      "merchantCommissionRate": 0E-8,
      "merchantCommissionRateAmount": 0.00,
      "iyziCommissionRateAmount": 0.40040000,
      "iyziCommissionFee": 0.25000000,
      "cardType": "CREDIT_CARD",
      "cardAssociation": "MASTER_CARD",
      "cardFamily": "Axess",
      "binNumber": "552608",
      "lastFourDigits": "0006",
      "basketId": "B67832",
      "currency": "TRY",
      "itemTransactions": [
          {
              "itemId": "BI101",
              "paymentTransactionId": "20945921",
              "transactionStatus": 2,
              "price": 10.01,
              "paidPrice": 10.01000000,
              "merchantCommissionRate": 0E-8,
              "merchantCommissionRateAmount": 0E-8,
              "iyziCommissionRateAmount": 0.40040000,
              "iyziCommissionFee": 0.25000000,
              "blockageRate": 0E-8,
              "blockageRateAmountMerchant": 0E-8,
              "blockageRateAmountSubMerchant": 0,
              "blockageResolvedDate": "2023-06-18 00:00:00",
              "subMerchantPrice": 0,
              "subMerchantPayoutRate": 0E-8,
              "subMerchantPayoutAmount": 0,
              "merchantPayoutAmount": 9.35960000,
              "convertedPayout": {
                  "paidPrice": 10.01000000,
                  "iyziCommissionRateAmount": 0.40040000,
                  "iyziCommissionFee": 0.25000000,
                  "blockageRateAmountMerchant": 0E-8,
                  "blockageRateAmountSubMerchant": 0E-8,
                  "subMerchantPayoutAmount": 0E-8,
                  "merchantPayoutAmount": 9.35960000,
                  "iyziConversionRate": 0,
                  "iyziConversionRateAmount": 0,
                  "currency": "TRY"
              }
          }
      ],
      "authCode": "013627",
      "phase": "AUTH",
      "hostReference": "mock00007iyzihostrfn"
    }
  end
end