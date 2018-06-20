# What is an Identity

TODO review and expand

Let's discuss what is an identity for the sake of this document.

As a first step, let's think about identities as some means to identify people. Even when it is possible to define an identity system which may be unrelated to people (e.g. mineral classification), for the purpose of this document, highest level identities refer to people.

Of course, there are important things that are not people and are important for us, such as the devices of people, the buildings where they work, the cities where they live, etc. In case you're wondering yes, there are things that are related to the previous
The most important identities belong to persons or are defined to refer to them. Digital identities are related to persons in the same way.

Identity refers to the type of entities that are useful for your purpose. Thinking of persons as the most important elements of work for most company systems, the rest fo the entities and their identities are subordinated to the first ones.

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

## What we can do with an ID

It can be simplified to just two things:
- Read, Update and Delete operations on an entity: Ok, this is the obvious one.
- Cross information from different sources: This is more interesting. If we have the same ID in two different databases, we can cross the information in them.

What cannot (and should not) be simplified is the set of implications for these two things. It enables sharing information across products, across department and across countries.

This information sharing is not restricted to "after-the-fact" operations. It also enables online authorisation, online information showing for our customers, online and unified management of information, etc.

In case this sounds too good to be true, I'll enforce the word "enables"; it does not mean it happens overnight and automatically; it means it cannot happen smoothly without it.

## What usually happens regarding identifiers

Once we have discussed what good identifiers are and what should not be, let's talk about what happens regarding identifiers in the real world.

### Different identifiers are defined on a per system basis

Since it is uncommon to have strict identifier policies when the organisation is created, each system tries to solve the identification problem in the easiest (fastest, cheapest) way.

Some of the typical solutions are:
- If the system uses a directory to store identities, the DN (Distinguished Name) is used as the identifier. This ID is useful just within the repository; it ties the system to the technology chosen for the storage of the information.
- If the application enables consumer self-registration, the email is used. For this choosing to be perfect, we have to assume a person does not register with more than one email (this is something possibly no one has ever done to get a second free month from Netflix ;) ), suppose the user will be loyal to his email domain forever.
- If the system deals with people from a single nationality, use the national id card. This may work (apart from some mistakes by public administration) if the company works in just one country. If the company works in different countries, identifiers are different; if a user belongs to two countries problems may arise.
- If the system deals with people who have a passport, that ID is used. This is a good approach, given you can convince your users to have a passport and give you the ID.
- If the system creators feel lonely, an internal identifier is used; this identifier may be a composition of the entity attributes (e.g. first name plus last name), an auto-incremental value of a database, a declaredly local identifier (e.g. my-system-0001), a [UUID](https://tools.ietf.org/html/rfc4122) or some other locally defined ID. If the identifier is not good even locally (e.g. it is prone to collisions) it should be changed; if it is good, but it is local, it is a good candidate for mapping to a global identifier.

### The same entity is identified by two different identifiers
TODO

### We cannot match entities in a system with entities in a different system

TODO re-build identifiers or have a matching algorithm or store the mapping

## Identity federation

With identity federation I mean the ability to integrate information about an entity from different repositories.

We have concluded in the real world it is quite uncommon to have a common identifier for all systems. This means we need some hack in order for this federation to work.

The options for this hack require a balance between refactoring, strict policy setting and identifier mapping. Let's take a look at them:
- Refactoring: modifying the identifier of a system in order to use a more global identifier. This requires de definition of a global identifier across the company and the modification in the target system (which is not always possible).
- Strict policy setting: We can set a policy to infer an identifier from the information about a user. A typical example of this is the use of the first letter of the first name plus the last name as the ID for the email. This may work until you have collisions and you have people changing their name (e.g. getting married). This policy must be carefully chosen and is almost never a perfect solution in the long term.
- Identifier mapping: Establishing a mapping between a global identifier (or an identifier in a different system) and the value of the identifier in the target system. The cost of this solution falls in between the other two, and usually well prepared for the changes in the future.

Once we have some means to traverse repositories in the same way we could traverse tables using SQL foreign keys, we're prepared to make use of the information.

## Identity unfederability

TODO What do we do when we specifically do NOT want the identity information to be crossed.

## Which is a good identifier for a company

TODO internal identifier, because we want to cross information internally, but not externally.

TODO complete
TODO an employee which is also an external is two entities or just one?
