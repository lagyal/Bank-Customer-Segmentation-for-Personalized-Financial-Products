with customer_metrics as (
  select
    customerid,
    count(TransactionID) as total_transactions,
    avg(TransactionAmount) as avg_transaction_amount,
    max(CustAccountBalance) as account_balance
  from bank_transactions
  group by customerid
)
select
  customerid,
  total_transactions,
  avg_transaction_amount,
  account_balance,
	case
    when total_transactions = 1
		and account_balance > 300000
	then 'High Value Dormant'
    
    when total_transactions > 2
         and avg_transaction_amount > 500
         and account_balance > 200000
      then 'Gold Customer'

    when total_transactions > 1
         and avg_transaction_amount > 200
         and account_balance > 100000
      then 'Silver Customer'
	
    else 'Bronze Customer'
  end as customer_segment
from customer_metrics;