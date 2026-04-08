/// Approximate exchange rates to USD for cross-currency normalisation.
///
/// Covers both ISO 4217 codes (from YouTube Data API) and common currency
/// symbols (from scrape path).  Rates are static approximations — good enough
/// for sorting and dashboard totals, not for accounting.
const _rates = <String, double>{
  // ISO 4217
  'USD': 1.0, 'JPY': 0.0067, 'EUR': 1.08, 'GBP': 1.27,
  'TWD': 0.031, 'HKD': 0.128, 'KRW': 0.00069, 'CAD': 0.72,
  'AUD': 0.63, 'SGD': 0.74, 'MXN': 0.050, 'BRL': 0.18,
  'INR': 0.012, 'PHP': 0.018, 'THB': 0.028, 'MYR': 0.22,
  'VND': 0.000039,
  'CHF': 1.12, 'SEK': 0.095, 'NOK': 0.095, 'DKK': 0.145,
  'NZD': 0.60, 'ZAR': 0.054, 'IDR': 0.000061, 'CLP': 0.001,
  'CNY': 0.138, 'TRY': 0.026, 'CZK': 0.044, 'PLN': 0.25,
  'HUF': 0.0027, 'ILS': 0.27, 'SAR': 0.267,
  // Common symbols (scrape)
  r'$': 1.0, '¥': 0.0067, '€': 1.08, '£': 1.27,
  r'NT$': 0.031, r'HK$': 0.128, r'A$': 0.63, r'CA$': 0.72,
  r'C$': 0.72, r'S$': 0.74, r'MX$': 0.050, r'R$': 0.18,
  '₩': 0.00069, '₹': 0.012, '₱': 0.017, '฿': 0.028,
  '₫': 0.000039, '₺': 0.026,
};

const supportedDisplayCurrencies = <String>[
  'USD',
  'JPY',
  'TWD',
  'EUR',
  'GBP',
  'CAD',
  'AUD',
  'HKD',
  'KRW',
  'SGD',
];

/// Convert [amountMicros] in [currency] to an approximate USD value.
double normalizeToUsd(String currency, int amountMicros) {
  final rate = _rates[currency] ?? 1.0;
  return amountMicros / 1000000.0 * rate;
}

double convertFromUsd(double amountUsd, String targetCurrency) {
  final targetRate = _rates[targetCurrency] ?? 1.0;
  return amountUsd / targetRate;
}

double convertAmount(
  String sourceCurrency,
  int amountMicros,
  String targetCurrency,
) {
  return convertFromUsd(
    normalizeToUsd(sourceCurrency, amountMicros),
    targetCurrency,
  );
}

String formatConvertedAmount(String currency, double amount) {
  return '$currency ${amount.toStringAsFixed(2)}';
}

/// Format a human-readable amount string such as `¥ 500` or `USD 5.00`.
String formatCurrencyAmount(String currency, int amountMicros) {
  final amount = amountMicros / 1000000.0;
  return '$currency ${amount.toStringAsFixed(2)}';
}

String formatRawCurrencyAmount(String currency, double amount) {
  return '$currency ${amount.toStringAsFixed(2)}';
}

/// Maps ISO 4217 currency codes to their commonly used symbols.
const _currencySymbols = <String, String>{
  'USD': r'$', 'JPY': '¥', 'EUR': '€', 'GBP': '£',
  'TWD': r'NT$', 'HKD': r'HK$', 'KRW': '₩', 'CAD': r'CA$',
  'AUD': r'A$', 'SGD': r'S$', 'MXN': r'MX$', 'BRL': r'R$',
  'INR': '₹', 'PHP': '₱', 'THB': '฿', 'MYR': 'RM',
  'VND': '₫',
  'CHF': 'CHF', 'SEK': 'kr', 'NOK': 'kr', 'DKK': 'kr',
  'NZD': r'NZ$', 'ZAR': 'R', 'IDR': 'Rp', 'CLP': r'CL$',
  'CNY': '¥', 'TRY': '₺', 'CZK': 'Kč', 'PLN': 'zł',
  'HUF': 'Ft', 'ILS': '₪', 'SAR': '﷼',
};

/// Returns the currency symbol for [code], or [code] itself if unknown.
String currencySymbol(String code) => _currencySymbols[code] ?? code;
