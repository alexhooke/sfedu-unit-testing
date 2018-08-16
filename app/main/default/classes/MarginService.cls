public with sharing class MarginService{

    public static void applayMargin(List<Purchase_Product__c> purchaseProducts) {

        List<Margin_Rule__c> marginRules = [SELECT Field__c, Type__c, Value__c FROM Margin_Rule__c LIMIT 10000];

        for (Purchase_Product__c pp : purchaseProducts) {
            for (Margin_Rule__c marginRule : marginRules) {

                if (marginRule.Type__c == 'Addition') {
                    pp.put(
                        marginRule.Field__c,
                        (Decimal)pp.get(marginRule.Field__c) + marginRule.Value__c
                    );
                }

                if (marginRule.Type__c == 'Factor') {
                    pp.put(
                        marginRule.Field__c,
                        (Decimal)pp.get(marginRule.Field__c) * marginRule.Value__c
                    );
                }

                if (marginRule.Type__c == 'Set') {
                    pp.put(marginRule.Field__c, marginRule.Value__c);
                }
            }
        }

        update purchaseProducts;
    }
}