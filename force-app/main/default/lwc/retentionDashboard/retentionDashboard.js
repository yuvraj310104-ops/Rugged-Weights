
import { LightningElement, wire } from 'lwc';
import getExpiringMemberships
    from '@salesforce/apex/MembershipRetentionController.getExpiringMemberships';

const COLUMNS = [
    { label: 'Membership', fieldName: 'Name' },
    { label: 'Member', fieldName: 'memberName' },
    { label: 'Expiry Date', fieldName: 'End_Date__c', type: 'date' },
    { label: 'Status', fieldName: 'Status__c' },
    { label: 'Renewal Outcome', fieldName: 'Renewal_Outcome__c' }
];

export default class RetentionDashboard extends LightningElement {
    columns = COLUMNS;
    memberships = [];
    error;

    @wire(getExpiringMemberships)
    wiredMemberships({ data, error }) {
        if (data) {
            this.memberships = data.map(record => ({
                ...record,
                memberName: record.Contact__r?.Name
            }));
            this.error = undefined;
        } else if (error) {
            this.memberships = [];
            this.error = error;
        }
    }

    get hasMemberships() {
        return this.memberships.length > 0;
    }
}
