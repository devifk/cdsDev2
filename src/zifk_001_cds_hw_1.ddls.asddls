@AbapCatalog.sqlViewName: 'ZIFK_001V_CDS2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Homework Example Week 2'
define view ZIFK_001_CDS_HW_1
  as select from    vbrp
    inner join      vbrk on vbrk.vbeln = vbrp.vbeln
    inner join      mara on mara.matnr = vbrp.matnr
    left outer join makt on makt.matnr = mara.matnr
    left outer join vbak on vbak.vbeln = vbrp.aubel
    left outer join kna1 on kna1.kunnr = vbak.kunnr
{
  key vbrp.vbeln,
      vbrp.posnr,
      vbrp.aubel,
      vbrp.aupos,
      vbak.kunnr,
      concat_with_space( kna1.name1, kna1.name2, 1 )                                                                                as kunnrAd,
      @Semantics.amount.currencyCode: 'Currency'
      vbrp.netwr                                                                                                                                              as Amount,
      @Semantics.amount.currencyCode: 'Currency'
      currency_conversion( amount=>vbrp.netwr, source_currency=>vbrk.waerk, target_currency=>cast('EUR' as abap.cuky( 5 )) , exchange_rate_date=>vbrk.fkdat ) as EurAmount,
      vbrk.waerk                                                                                                                                              as Currency,
      left(vbak.kunnr,3)                                                                                                                                      as CustomerFirst3,
      length(vbrp.matnr)                                                                                                                                      as MaterialNrLength,
      case vbrk.fkart when 'FAS' then 'Peşinat Talebi İptali'
                      when 'FAZ' then 'Peşinat Talebi'
                      else 'Fatura' end                                                                                                                       as InvoiceType,
      vbrk.fkdat                                                                                                                                              as InvoiceDate,
      vbrk.inco2_l                                                                                                                                            as IncotermsLocation
}
