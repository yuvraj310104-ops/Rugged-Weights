public with sharing class MembershipTriggerHandler {
    public static void validateDates(List<Membership__c> memberships) {
        for (Membership__c membership : memberships) {
            if (membership.Start_Date__c != null && membership.End_Date__c != null   ) {
                if (membership.Start_Date__c > membership.End_Date__c) {
                    membership.addError('Start Date cannot be after End Date.');
                }
            }
        }
    }
}