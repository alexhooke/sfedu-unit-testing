@IsTest
public class PurchaseProductTriggerHandlerTest {

    @IsTest
    static void handleBeforeInsertTest() {

        List<Purchase_Product__c> purchaseProducts = new List<Purchase_Product__c>();

        Test.startTest();
        for (Integer i = 1; i <= 10; i++) {
            Purchase_Product__c pp = new Purchase_Product__c(Install_Charges__c = 50 * i, Monthly_Charges__c = 78 * 2 * i);
            purchaseProducts.add(pp);
        }
        insert purchaseProducts;

        List<Product2> products = [SELECT Name, Monthly_Charges__c, Install_Charges__c FROM Product2];
        Test.stopTest();

        System.assertEquals(purchaseProducts.size(), products.size());
        System.assertEquals(purchaseProducts[0].Monthly_Charges__c, products[0].Monthly_Charges__c);
    }

    @IsTest
    static void handleBeforeUpdateTest() {

        List<Purchase_Product__c> purchaseProducts = new List<Purchase_Product__c>();
        Purchase_Product__c pp = new Purchase_Product__c();

        for (Integer i = 1; i <= 10; i++) {
            pp = new Purchase_Product__c(Install_Charges__c = 50 * i, Monthly_Charges__c = 78 * 2 * i);
            purchaseProducts.add(pp);
        }
        insert purchaseProducts;

        Test.startTest();
        pp = [SELECT Name, Monthly_Charges__c, Install_Charges__c,Sales_Product__c FROM Purchase_Product__c LIMIT 1];
        pp.Monthly_Charges__c = 124;
        update pp;

        id ppId = pp.Sales_Product__c;
        Product2 product = [SELECT Name, Monthly_Charges__c, Install_Charges__c FROM Product2 WHERE id =: ppId];
        Test.stopTest();

        System.assertEquals(pp.Monthly_Charges__c, product.Monthly_Charges__c);
    }

    @IsTest
    static void handleAfterDeleteTest() {

        List<Purchase_Product__c> purchaseProducts = new List<Purchase_Product__c>();
        Purchase_Product__c purchaseProduct = new Purchase_Product__c();
        Set<Id> ppIds = new Set<Id>();

        for (Integer i = 1; i <= 10; i++) {
            purchaseProduct = new Purchase_Product__c(Install_Charges__c = 50 * i, Monthly_Charges__c = 78 * 2 * i);
            purchaseProducts.add(purchaseProduct);
        }
        insert purchaseProducts;

        Test.startTest();
        delete purchaseProducts[0];
        purchaseProducts = [SELECT id FROM Purchase_Product__c];
        List<Product2> products = [SELECT Name, Monthly_Charges__c, Install_Charges__c FROM Product2];
        Test.stopTest();

        System.assertEquals(purchaseProducts.size(), products.size());
    }
}