MoneyRails.configure do |config|
  config.default_currency = :brl

  config.include_validations = true

  config.amount_column = {
    prefix: '',        # column name prefix
    postfix: '_cents', # column name  postfix
    column_name: nil,  # full column name (overrides prefix, postfix and accessor name)
    type: :integer,    # column type
    present: true,     # column will be created
    null: true,        # other options will be treated as column options
    default: nil
  }

  config.currency_column = {
    prefix: '',
    postfix: '_currency',
    column_name: nil,
    type: :string,
    present: true,
    null: true,
    default: nil
  }

  config.rounding_mode = BigDecimal::ROUND_HALF_UP
  config.raise_error_on_money_parsing = true
end

Money.locale_backend = :currency
