# Identity federation

Identity federation is the ability to integrate information about an entity from different repositories.

We have concluded in the real world it is quite uncommon to have a common identifier for all systems. This means we need some hack in order for this federation to work.

The options for this hack require a balance between refactoring, strict policy setting and identifier mapping. Let's take a look at them:
- Refactoring: modifying the identifier of a system in order to use a more global identifier. This requires de definition of a global identifier across the company and the modification in the target system (which is not always possible).
- Strict policy setting: We can set a policy to infer an identifier from the information about a user. A typical example of this is the use of the first letter of the first name plus the last name as the ID for the email. This may work until you have collisions and you have people changing their name (e.g. getting married). This policy must be carefully chosen and is almost never a perfect solution in the long term.
- Identifier mapping: Establishing a mapping between a global identifier (or an identifier in a different system) and the value of the identifier in the target system. The cost of this solution falls in between the other two, and usually well prepared for the changes in the future.

Once we have some means to traverse repositories in the same way we could traverse tables using SQL foreign keys, we're prepared to make use of the information.

I think what really gives value to the identities is the relationship between them. When crossing information across repositories we do not only enrich individual identities; we also increase the relationships between them.

This enrichment is such an army knife (it can be used for so many things) that in many cases the initiatives to federate identity information across the company lacks a specific sponsor (with enough weight in the company as to make it possible). Some cases it happens because there is no single and clear use case and sometimes because it requires aligning too many actors.

## Identity Un-federation

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
