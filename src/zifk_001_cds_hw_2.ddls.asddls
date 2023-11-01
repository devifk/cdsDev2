@AbapCatalog.sqlViewName: 'ZIFK_000V_2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Homework Example Week 2 - 2'
define view ZIFK_001_CDS_HW_2
  as select from ZIFK_001_CDS_HW_1 as base
{
  key base.vbeln,
      @Semantics.amount.currencyCode: 'Currency'
      sum(base.EurAmount)                  as totalAmount,
      base.Currency,
      base.kunnrAd,
      count(*)                             as numberOfInvoice,
      avg( Amount )                        as averageAmount,
      left( InvoiceDate, 4)                as invoiceYear,
      substring( InvoiceDate, 5, 2)        as invoiceMonth,
      substring( InvoiceDate, 7, 2)        as invoiceDay,
      substring( IncotermsLocation, 1, 3 ) as incotermsFirst3
}
group by
  base.vbeln,
  base.Currency,
  base.kunnrAd,
  base.InvoiceDate,
  base.IncotermsLocation
