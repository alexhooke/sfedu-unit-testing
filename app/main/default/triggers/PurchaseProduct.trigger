trigger PurchaseProduct on Purchase_Product__c (before insert, before update) {

    if (Trigger.isBefore && Trigger.isInsert) {
        PurchaseProductTriggerHandler.handleBeforeInsert(Trigger.new);
    }

    if (Trigger.isBefore && Trigger.isUpdate) {
        PurchaseProductTriggerHandler.handleBeforeUpdate(Trigger.new. Trigger.old);
    }
}