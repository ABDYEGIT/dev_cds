@AbapCatalog.sqlViewName: 'Z4891_V_CDS1_HW2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Homework 2 CDS 1'
define view ZAYEGIT_V_CDS1_HW2
  as select from    vbrp
    inner join      vbrk on vbrk.vbeln = vbrp.vbeln
    inner join      mara on mara.matnr = vbrp.matnr
    left outer join vbak on vbak.vbeln = vbrp.aubel
    left outer join kna1 on kna1.kunnr = vbak.kunnr
    left outer join makt on  makt.matnr = mara.matnr
                         and makt.spras = $session.system_language
{
  key vbrp.vbeln,
  key vbrp.posnr,
      vbrp.aubel,
      vbak.kunnr,
      concat_with_space(kna1.name1,kna1.name2 , 2) as kunnr_Ad,
      currency_conversion(amount=>vbrp.netwr,
                 source_currency=>vbrk.waerk,
                 target_currency=>cast('EUR' as abap.cuky),
              exchange_rate_date=>vbrk.fkdat)      as conversion_netwr,
      left(kna1.kunnr,3)                           as left_kunnr,
      length(mara.matnr)                           as matnr_length,
      case vbrk.fkart
      when 'FAS' then 'Peşinat talebi iptali'
      when 'FAZ' then 'Peşinat talebi'
      else 'Fatura' end                            as invoicetype,
      vbrk.fkdat,
      vbrk.inco2_l
}
