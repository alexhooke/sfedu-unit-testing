@IsTest
public class MarginServiceTest {

    @IsTest
    static void applayMarginTest() {

        List<Margin_Rule__c> marginRules = new List<Margin_Rule__c>{
            new Margin_Rule__c(Field__c = 'Install_Charges__c', Type__c = 'Addition', Value__c = 12),
            new Margin_Rule__c(Field__c = 'Install_Charges__c', Type__c = 'Factor', Value__c = 8),
            new Margin_Rule__c(Field__c = 'Monthly_Charges__c', Type__c = 'Set', Value__c = 120)
        };
        insert marginRules;

        List<Purchase_Product__c> purchaseProducts = new List<Purchase_Product__c>();
        for (Integer i = 1; i <= 10; i++) {
            Purchase_Product__c pp = new Purchase_Product__c(Install_Charges__c = 50 * i, Monthly_Charges__c = 78 * 2 * i);
            purchaseProducts.add(pp);
        }
        insert purchaseProducts;

        Test.startTest();
        MarginService.applayMargin(purchaseProducts);
        Test.stopTest();

        purchaseProducts = [SELECT Monthly_Charges__c, Install_Charges__c  FROM Purchase_Product__c];
        List<Product2> products = [SELECT Monthly_Charges__c, Install_Charges__c FROM Product2];

        System.assertEquals(120, purchaseProducts[0].Monthly_Charges__c);
        System.assertEquals(purchaseProducts[0].Install_Charges__c, products[0].Install_Charges__c);
        System.assertEquals(496, products[0].Install_Charges__c);
    }

}