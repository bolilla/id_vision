# What is an Identity

Let's discuss what is an identity for the sake of this document.

As a first step, let's think about identities as some means to identify people. Even when it is possible to define an identity system which may be unrelated to people (e.g. mineral classification), for the purpose of this document, highest level [Digital] Identities refer to people.

Of course, there are important things that are not people, and are still relevant for us, such as the devices used by out users, the buildings where they work, the cities where they live, the privileges these people have, etc. We will treat people as first class entities and the rest of the list as second class ones.

There are some other identities that we must take into account and are often forgotten. Most important ones are the identities that relate to IT systems, and the identities that relate to IoT devices. In these two cases, the management is not related to the management of the identities of people.

## Identifier

Knowing what an identity is, and assuming it refers to the identification of an entity, let's discuss what does a good identifier look like and which are its uses.

Forgive me if I go from truism to truism, but I want the reasoning to go smooth.

- An identifier identifies an entity: My passport ID identifies me, and my passport ID does not identify any other person. It should not even if we share the same name, last name, gender, date of birth and the rest of the elements of information in my passport.
- An entity should have only one identifier of a given type: I may have a national ID card with a different ID than the one in my passport, but I should not have more than one passport. This means that when (not if, but when) this happens (and this is not exclusive to fiction movies), we have a problem to address.
- An entity ID does not change unless the true nature of the entity changes: I can change my name, address, gender and physical aspect and I should remain with the same ID. This means that it is not (just) the information registered about me that defines who I am.

This implies some qualities that a good identifier should not have:
- An identifier should not be based (just) on the information registered: I may change my email address and name and remain being the same person.
- An identifier should not be a composition of the information provided: Hashing a record to create an indexable ID becomes a problem when the record changes.
- If identifiers are provided by different (non-synchronized) parties, the ID space should not be shared: I know it is common sense, but it would not have been the first time when two different offices create documents for different people with the same ID, or two traffic offices register the same plate.

### What we can do with an ID

It can be simplified to just two things:
- Read, Update and Delete operations on an entity: Ok, this is the obvious one.
- Cross information from different sources: This is more interesting. If we have the same ID in two different databases, we can cross the information in them.

What cannot (and should not) be simplified is the set of implications for these two things. It enables sharing information across products, across department and across countries.

This information sharing is not restricted to "after-the-fact" operations. It also enables online authorisation, online information showing for our customers, online and unified management of information, etc.

In case this sounds too good to be true, I'll enforce the word "enables"; it does not mean it happens overnight and automatically; it means it cannot happen smoothly without it.

### What usually happens regarding identifiers

Once we have discussed what good identifiers are and what should not be, let's talk about what happens regarding identifiers in the real world.

#### Different identifiers are defined on a per system basis

Since it is uncommon to have strict identifier policies when the organisation is created, each system tries to solve the identification problem in the easiest (fastest, cheapest) way.

Some of the typical solutions are:
- If the system uses a directory to store identities, the DN (Distinguished Name) is used as the identifier. This ID is useful just within the repository; it ties the system to the technology chosen for the storage of the information.
- If the application enables consumer self-registration, the email is used. For this choosing to be perfect, we have to assume a person does not register with more than one email (this is something possibly no one has ever done to get a second free month from Netflix ;) ), suppose the user will be loyal to his email domain forever.
- If the system deals with people from a single nationality, use the national id card. This may work (apart from some mistakes by public administration) if the company works in just one country. If the company works in different countries, identifiers are different; if a user belongs to two countries problems may arise.
- If the system deals with people who have a passport, that ID is used. This is a good approach, given you can convince your users to have a passport and give you the ID.
- If the system creators feel lonely, an internal identifier is used; this identifier may be a composition of the entity attributes (e.g. first name plus last name), an auto-incremental value of a database, a declaredly local identifier (e.g. my-system-0001), a [UUID](https://tools.ietf.org/html/rfc4122) or some other locally defined ID. If the identifier is not good even locally (e.g. it is prone to collisions) it should be changed; if it is good, but it is local, it is a good candidate for mapping to a global identifier.

#### The same entity is identified by two different identifiers

This may happen on purpose in the beginning of time (e.g. a user that registers two different identities to get a "sign in" benefit twice), we may know about this at some point in time (e.g. we find that John Doe owns two accounts: one called `jdoe`, that is not used anymore and `john.doe` with the newer policy for ID generation). Maybe this happened because of technical reasons (e.g. a user has two usernames because the system only allows one privilege profile per account) or because of personal preferences (e.g. John Doe requested a new account because `firebolt` seemed to be a cooler ID than `jdoe`).

In either case, the situation is the same: we have a duplication to deal with.

We can do a number of things:
- Delete the invalid value: this would be the easiest option, but it is not always conceivable or convenient (e.g. both accounts are being heavily used).
- Merge the information in just one account: this can be a good option if the system allows aliases for the identifier (e.g. email addresses).
- Register the duplication within the system: create a registry for this kind of scenarios. The creation, maintenance and adaptation of the tools to use it makes it impractical for many cases.
- Register the duplication in the association with a higher-level identity: This approach is available in many IDMs (IDentity Management system), and it has the least impact in the system where the duplication happens.

No matter what action we decide to take, the end must be one of these: either the duplication is eliminated, or it is accounted for and taken into account.

#### We cannot match accounts in a system with the person who uses it

I have known people who wouldn't believe this could ever happen in a company. Unfortunately the sad truth is there are companies, systems and accounts with this situation: the only way to find out whether the account with identifier `jdoe` belongs to John Doe or Jennifer Doe is by asking them directly.

Of course this only happens in certain companies, in certain systems and for certain accounts. This is nothing more than a minimum percentage of the overall account count.

As in the previous case, the most typical way of dealing with this is by adding a relationship between the person and the account in the corporate IDM. Adding a field for the matching (e.g. a global identifier within the company) may also be a good option if the system allows it.

#### Orphan accounts

In the previous case, we had an account that belonged to someone and we were not sure who the identifier referred to. In this case, we find an account that has not been used for a long time (if we know when was the last login for this account we are on the good track), and we are uncertain about whether it is used any more or not.

The most common way to deal with this situation is by disabling all accounts which have not been used for a long time (e.g. six months). This does not provide immediate information about who the account belongs to, or whether it is used at all, but solves a possible security hole.

Please beware that this is not a good option in two cases: systems that charge per account (some of them do not charge for disabled accounts), and systems that are seldom used because of their intrinsic nature; I had a really bad time when we disabled accounts in a system that was used to make the annual accounting reconciliation (with emphasis in "annual").

#### Accounts for systems or things which have no person in charge

Banking is a context where changes to not happen overnight. We all know stories about people in banking who have created quick and dirty programs which were supposed to "last for just a few months until the final solution arrives", and these systems have outlived their creators.

I believe the identity of a system does not have to be subordinated to the one of a person, but there must be some way to govern that identity, and (so far) it takes people to make the governing.

Depending on the company, the maturity in the management of these account varies, but in most cases it is a matter that does not receive enough attention.

Anecdotes go from entire departments that disappear and no one owns these accounts anymore, to production systems that fail overnight because there was some crucial service running with the personal account of an employee who has retired.

This is certainly one of the many aspects of Identity Management that needs to be acknowledged by companies and taken care of by ID professionals.

## Identity federation

With identity federation I mean the ability to integrate information about an entity from different repositories.

We have concluded in the real world it is quite uncommon to have a common identifier for all systems. This means we need some hack in order for this federation to work.

The options for this hack require a balance between refactoring, strict policy setting and identifier mapping. Let's take a look at them:
- Refactoring: modifying the identifier of a system in order to use a more global identifier. This requires de definition of a global identifier across the company and the modification in the target system (which is not always possible).
- Strict policy setting: We can set a policy to infer an identifier from the information about a user. A typical example of this is the use of the first letter of the first name plus the last name as the ID for the email. This may work until you have collisions and you have people changing their name (e.g. getting married). This policy must be carefully chosen and is almost never a perfect solution in the long term.
- Identifier mapping: Establishing a mapping between a global identifier (or an identifier in a different system) and the value of the identifier in the target system. The cost of this solution falls in between the other two, and usually well prepared for the changes in the future.

Once we have some means to traverse repositories in the same way we could traverse tables using SQL foreign keys, we're prepared to make use of the information.

I think what really gives value to the identities is the relationship between them. When crossing information across repositories we do not only enrich individual identities; we also increase the relationships between them.

This enrichment is such an army knife (it can be used for so many things) that in many cases the initiatives to federate identity information across the company lacks a specific sponsor (with enough weight in the company as to make it possible). Some cases it happens because there is no single and clear use case and sometimes because it requires aligning too many actors.

## Identity unfederability

There are times when we do not want the information of a repository to be federated with other repositories.

This is more common than we may think:
- We provide identifiers to third parties for them to refer to our identities (normally employees or customers), but we do not want them to know who is the person behind the identifier.
- We fear finding a credit card database dump in the deep web.
- We want to execute some work on a database that cannot relate the information with real subjects (e.g. database dumps for software developers)

In these cases (and supposing the company wants to maintain the ability to make the matching with actual identities) most common options are:
- Create a database to store the mapping of the identifiers.
- Use some FPE [Format Preserving Encryption](https://en.wikipedia.org/wiki/Format-preserving_encryption) algorithm and store only the key.

In the first case, there is a new database to manage (and backup, and make available, etc) and the mapping may be updated at some point with a limited impact; in the second case there is only one element of information for all the mapping, which is easier to manage and more troublesome when lost (or shared).

## Which is a good identifier for a company

Taking into account all this, I personally believe a company should have its own global identifier, unrelated to any element of information of the entity, using the same address space for all kinds of identities (employees, customers, devices, services, etc). [UUID](https://tools.ietf.org/html/rfc4122) seems to be a good starting point.

May be this is sounds overkill; I can hear voices saying it does not pay off having a 128 bits identifier for a group when all the information about the group is the name, when the name is as short as `admin`, when the name of the group is unique for the whole system, when spelling a UUID is annoying, given you have to externally map the identifier for systems that do not allow the use of custom identifiers, etc. Even in this case, I would stand for a global identifier.

## What happens when an entity legally belongs to two different entity types

We are not going to see an IoT device that is also an employee of the company (at least not in the short term), but we can find internal employees who have been external contractors, and at the same time consumers of our services and paying customers.

In these cases I would suggest to have one single identity, one single identifier, and as many accounts as they are needed.
