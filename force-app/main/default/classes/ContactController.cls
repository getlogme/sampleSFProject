public with sharing class ContactController {
    public ContactController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [ SELECT Id, Name, Title, Phone, Email FROM Contact LIMIT 10 ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> findContacts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [SELECT Id, Name, Title, Phone, Email FROM Contact LIMIT 10 ];
    }

    @AuraEnabled(cacheable=true)
    public static Contact getSingleContact(Contact contactKey) {
        System.debug('Contact '+contactKey);
        return [SELECT Id, Name, Title, Phone, Email FROM Contact LIMIT 1 ];
    }
}