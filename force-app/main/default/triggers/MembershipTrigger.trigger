trigger MembershipTrigger on Membership__c (before insert, after insert) {
    MembershipTriggerHandler.validateDates(Trigger.new);

}