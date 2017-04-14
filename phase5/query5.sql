select b.branchId, b.phoneNo, sum(invoice) as cost
from (
    select f.BID, f.purchaseDate, f.invoice from Purchases_Food as f
    union all
    select s.BID, s.purchaseDate, s.invoice from Purchases_Supply as s
    union all
    select v.BID, v.purchaseDate, v.invoice from Purchases_Vehicle as v
) as p inner join Branch b on b.branchId = p.BID
where p.purchaseDate > dateAdd(day, -1000, getDate())
group by b.branchId, b.phoneNo;
