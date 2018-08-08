public with sharing class PurchaseProductTriggerHandler {

    public static void handleBeforeInsert(List<Purchase_Product__c> newRecords) {

        Map<Purchase_Product__c, Product2> pp2spMap = new Map<Purchase_Product__c, Product2>();

        for (Purchase_Product__c pp : newRecords) {

            Product2 product = new Product2(
                Name = 'Product',
                Monthly_Charges__c = pp.Monthly_Charges__c,
                Install_Charges__c = pp.Install_Charges__c,
                IsActive = true
            );

            pp2spMap.put(pp, product);
        }

        insert pp2spMap.values();

        for (Purchase_Product__c pp : newRecords) {
            pp.Sales_Product__c = pp2spMap.get(pp).Id;
        }
    }

    public static void handleBeforeUpdate(List<Purchase_Product__c> newRecords, List<Purchase_Product__c> oldRecords) {

        List<Id> idsPp = new List<Id>();
        for (Purchase_Product__c pp : oldRecords) {
            idsPp.add(pp.Sales_Product__c);
        }

        List<Product2> products = [
            SELECT Monthly_Charges__c,
                Install_Charges__c
            FROM Product2
            WHERE Id IN :idsPp LIMIT 10000
        ];

        Map<Id, Purchase_Product__c> newRecordsMap = new Map<Id, Purchase_Product__c>();
        for (Purchase_Product__c newPp : newRecords) {
            newRecordsMap.put(newPp.Sales_Product__c, newPp);
        }

        for (Product2 product : products) {
            product.Monthly_Charges__c = newRecordsMap.get(product.id).Monthly_Charges__c;
            product.Install_Charges__c = newRecordsMap.get(product.id).Install_Charges__c;
        }

        update products;
    }

	public static void handleAfterDelete(List<Purchase_Product__c> oldRecords) {

        List<Product2> productsForDeleting = new List<Product2>();
        for (Purchase_Product__c pp : oldRecords) {
            productsForDeleting.add(new Product2(Id = pp.Sales_Product__c));
        }

        delete productsForDeleting;
	}
}
