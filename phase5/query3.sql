select b.branchId, b.phoneNo, b.address, count(c.customerId) as count
from Customer c
inner join Branch b on b.branchId = c.BID
group by b.branchId, b.address, b.phoneNo;