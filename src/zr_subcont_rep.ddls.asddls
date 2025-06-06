@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Subcontratação'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZR_SUBCONT_REP
  as select from ztmmstkmovi004
{
  key matnr    as Product,
  key drecep   as Drecep,
      lifnr    as Lifnr,
      blnumber as Blnumber,
      ebeln    as PurchaseOrder,
      ebelp    as Ebelp,
      mblnr    as MaterialDocument,
      mjahr    as MaterialDocumentYear,
      belnr    as SupplierInvoice,
      gjahr    as FiscalYear,
      aufnr    as Aufnr
}
