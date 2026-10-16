public with sharing class MembershipRetentionController {
     @AuraEnabled(cacheable=true)
    public static List<Membership__c> getExpiringMemberships() {
        Date today = Date.today();
        Date cutoffDate = today.addDays(7);

        return [
            SELECT Id,
                   Name,
                   Contact__r.Name,
                   End_Date__c,
                   Status__c,
                   Renewal_Outcome__c
            FROM Membership__c
            WHERE Status__c = 'Active'
              AND End_Date__c >= :today
              AND End_Date__c <= :cutoffDate
              AND Reminder_Sent__c = false
            WITH USER_MODE
            ORDER BY End_Date__c ASC
            LIMIT 100
        ];
    }
}