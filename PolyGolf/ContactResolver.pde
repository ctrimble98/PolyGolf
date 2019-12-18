class ContactResolver {

    // Resolves a set of particle contacts
    void resolveContacts() {
        Iterator itr = contacts.iterator();
        while(itr.hasNext()) {
            Contact contact = (Contact)itr.next();
            contact.resolve();
        }
        contacts = new ArrayList<Contact>();
    }
}
