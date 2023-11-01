@AbapCatalog.sqlViewName: 'ZAYEGIT_V_CDS2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Homework 2 CDS 2'
define view ZAYEGIT_V_CDS2_HW2
  as select from ZAYEGIT_V_CDS1_HW2

{
  vbeln,
  sum(conversion_netwr)                                                                           as Total_NetValue,
  kunnr_Ad,
  count(*)                                                                                        as Total_InvoiceNumber,
  division(cast( sum(conversion_netwr) as abap.curr( 10, 3 ) ), cast( count(*) as abap.int1 ), 3) as Average_Quantity,
  left(fkdat,4)                                                                                   as Invoice_Year,
  substring(fkdat,5,2)                                                                            as Invoice_Month,
  substring(fkdat,7,2)                                                                            as Invoice_Day,
  substring(inco2_l,1,3)                                                                          as Incoterm_Location,
  fkdat
}
group by
  vbeln,
  kunnr_Ad,
  fkdat,
  inco2_l
