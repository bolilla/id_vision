# Authorisation Model

Even when this document tries to be applicable to identities independently of the use of them, this section refers specifically to the work involved in order to use identity information for authorisation, which by definition is a security concern.

## Classic authorisation models

Just in case the reader is not familiar with the classical authorisation models, let's quickly review them:

- **[MAC](https://en.wikipedia.org/wiki/Mandatory_access_control) (Mandatory Access Control),  [DAC](https://en.wikipedia.org/wiki/Discretionary_access_control) (Discretionary Access Control) and [ACL](https://en.wikipedia.org/wiki/Access_control_list) (Access Control List)**: These authorisation models are based on associating specific individual identities and entitlements (operation privileges on an object).
- **[RBAC](https://en.wikipedia.org/wiki/Role-based_access_control) (Role Based Access Control)**: Authorisation model that extends the previous ones by associating users (identities) to roles (which are identities too) and roles to entitlements.
- **[ABAC](https://en.wikipedia.org/wiki/Attribute-based_access_control) (Attribute Based Access Control)**: Authorisation model that extends the previous ones by associating identity attributes to authorisation policies and the authorisation policies to entitlements.

### A deeper look into RBAC

In this context we will think about a role as a group of entitlements, and an entitlement as the ability to perform a certain operation on an object. Whether an entitlement requires the creation of a user account in a system or the inclusion of a group in an existing account are details I am not going to deal with in this document. I'll count

Roles have classically been classified in many different ways depending on various criteria: if all the entitlements belong to the same system, the role may be a group; if the role contains entitlements of different systems, it's called a technical group; if the role contains a set of roles, the role is called "business role". I will not make any distinction for these regards. I think it is not necessary for the purpose of this document and it would complicate the reading.

RBAC is the most used authorisation model. It provides a balance between complexity and flexibility that suits most contexts. However, implementations of RBAC are differ from system to system.

In the following sub-sections I'll explain what characteristics must be present in a good implementation of RBAC.

#### Business rules

Business Rules are (as called by some Identity suite vendors) policies that automate the association of users to roles based on identity information. Examples: When a user moves to the sales department, it gets role "CRM-user", that provides her entitlements to access and manage customers in the CRM tool.

A good set of business rules will automate much of the process of providing entitlements to users; they are specially useful when a change to an identity (onboarding, department change, promotion, etc) happens.

A good implementation of the business rules should also have the following characteristics:

- Monitoring of changes in the identities' attributes to know when do they have to be triggered online
- Be applied to more than user-role relationships: modify other attributes, detect and alert inconsistencies in data, etc
- Detect when the rule no longer applies and its effects should be reversed (e.g. provided roles should be removed)

##### Dynamic roles and groups

Depending on the role and business rules implementation, it may be useful to count on dynamic roles or dynamic groups (I'll talk just about dynamic roles for simplification).

Dynamic roles are theoretically the same as business rules defined in a reverse way. A business rule states a condition and an association between a user and a role (e.g. users who belong to department sales, must have role r_sales); a dynamic role is a calculated role, and the calculus is done using a condition (e.g. the users who belong to role r_sales are those who belong to department sales).

From a practical point of view, and taking into account the implementation implications of dynamic roles, they make sense within a system, where the definition of the role (or group) can be done by a search filter (LDAP) or a query (SQL).

#### Business processes

Business process (related to identities) are the processes that state who can request permissions (roles in our case), who must approve that request, etc. Business processes tend to be extremely complex and a source of headaches for identity professionals.

I have seen two different approaches to business process (implementation): "try to make it as simple as possible" and use it as an audit trail, and "try to make it as exhaustive as possible" so it contains all the conversations that can possibly happen in the process.

Both approaches are based on the assumption (or the hope) that the business processes will not change (possibly because it is difficult to find budget for one IAM project, and "challenging" to find budget for a second one). I think both approaches miss the point. I believe in Martin Fowler's mantra "if it hurts, do it more often" ([here](https://martinfowler.com/bliki/FrequencyReducesDifficulty.html)). I think business processes evolve and their implementation must evolve too. Of course I think it is best to begin with a simple implementation and iterate over it, but the iterative evolution must be driven by feedback taken from use, not just interviews for a complex analysis in a waterfall development.

#### Attributes in the user-role relationship

When a user is associated to a role, that relationship may have attributes.

In case it is not obvious why this is mandatory, let's analyse the modelling of this authorisation scenario:

- There is an entitlement that enables a user to approve a mortgage. We'll call it e_mort_a
- There size of the mortgage that the user can approve is not the same for all users
- There is a role associated to that entitlement. We'll call it r_mort_a
- When a user is associated with the entitlement, the size of the mortgage that can be approved by the user is set.

In order to model this situation, we can decide to create many entitlements: r_mort_a_10K (for mortgages of up-to 10 K€), r_mort_a_50K, r_mort_a_100K, r_mort_a_200K, r_mort_a_500K, r_mort_a_1000K and r_mort_a_full (for mortgages of any amount). This will solve the problem of having one attribute in the relationship by creating 6 additional entitlements and 6 additional roles.

If at some point that same application decides that we will have different user profiles, and some of them will go door-to-door selling, but we do not want our sales people to have the same limits when going door-to-door and when approving mortgages in the office. We also decide that we do not want them to have the same amounts during office hours and out of office hours. In order to cope with this situation we will create 7 entitlements for out-of-the-office during- office-hours and 7 entitlements for in-the-office out-of-office-hours. We will have to create roles for all the possible combinations of these entitlements (2401), and this is the moment when we will remember that complexity does not grow linearly, but exponentially in identity management.

When this kind of complexities arise, the number of entitlements and roles grow exponentially unless we have attributes in the user-role (and user-entitlement) relationship.

#### Stating and storing reasons for user-role relationships

We must know why a user is associated to a role.

Whenever a user is associated to a role, there is a reason for it to happen. It may happen because some senior director decided it was required, because the employee himself decided he wanted it, because the association was triggered by a business rule when the user moved to this department, etc. In any case, the reason is important.

At some point, someone (possibly an external auditor) will ask "Why does this user have this role (or entitlement)?". At that moment, we better have a good answer. The only way I know for giving a correct answer in this kind of situation is by having the answer written somewhere.

There are other reasons to try and know why a user is associated to a role, and one of them is "removability"; if the reason for a user to have a role is no longer relevant, it can be removed. If the role was given because of a business rule, if the business rule is no longer matched (e.g. the user no longer belongs to the department that "grants" the role), it should be removed. Recertification of roles that have been manually given is much easier than adding to the recertification the roles that have been given  by automatic processes (of which the recertification may have no knowledge about).

#### Temporary user-role association

The relationship between a user and a role may be defined as temporary (with an expiry date).

One of the reasons for this is the tendency of human being to forget stuff that does not seem to be a priority, and (please believe me) removing privileges that are no longer needed is not a priority for most human beings.

I have heard colleagues arguing that all user-role associations should have an expiry date. I can see the point and I do not have strong arguments against the idea, but I feel reasonably comfortable with non-expiring privileges.

#### Multiple user-role relationships

A user must be able to have multiple relationships with the same role, because these relationships may have differences (even when the entitlements that they provide to the user may all be the same).

To illustrate this need, let's check this case:

- Adam belongs to consultancy department
- Adam is provided a role (let's call it "r_sales") that enables him to edit sales proposals for six months (enough time to help with a certain proposal for a customer)
- Adam is moved to the sales department, which grants him "r_sales" role
- Adam leaves the sales department, his department no longer grants him "r_sales" role

There are some conditions that have to happen:

- Adam has to have "r_sales" for six months
- Adam has to have "r_sales" while he is in the sales department

Apart from some other (more complex) ways of satisfying both conditions independently of the time when Adam joins and leaves sales department, it is possible to have a relationship Adam-6months-r_sales for six months independently of the relationship Adam-sales_department-r_sales.

#### Flexible role-entitlement relationship

The relationship between a role and the set of entitlements it provides must be based on parameters.

It may seem obvious that system administrators of google cloud and system administrators of amazon web services should have different entitlements. It may seem obvious that office employees in Mexico should have read access on customer information of Mexican customers and office employees in Spain should have read access on customer information of Spanish customers.

We may define different roles for different contexts (in addition to defining different entitlements), or we may push some intelligence in the role definition and let the information in the relationship user-role to address that matter.

The first option creates complexity. The kind of complexity in identity management; the one that grows exponentially (multiply the number of clouds by the number of entitlements, or the number of entitlements by the number of countries). The one we do not want to treat with.

Remember we also should have many user-role relationship and attributes in the relationship itself.

#### Relationship between roles

There are many different kinds of role to role relationships:

- **Inclusion / Inherits from**: If role A inherits from role B, role A provides at least the same amount of privileges as B. In addition, the changes in the set of privileges provided by B are automatically applied to A.
- **Exclusion**: If role A is exclusive to role B, if a user is associated to role A, it cannot be associated to role B. Please note this relationship should not be exclusive to roles. It should be possible to define exclusion relationship between roles, entitlements and systems (role-role, entitlement-entitlement, system-system, role-entitlement, role-system, entitlement-system)
- **Equivalent**: If role A is equivalent to role B, it provides the same set of entitlements. Equivalent roles are good candidates to be removed from the authorisation model.
- **Enables**: If role A enables role B, association of user to role B is either impossible or has no effect unless user is also associated to role A. This may be useful for example to separate management of privileges in a system from the ability to log in that system.
- **Other (custom) relationshps** (e.g. "creates risk when in conjunction with"): relationship that may be treated by business rules or live like annotations in the system. It may affect relationships between roles, entitlements and systems.

### A deeper look into ABAC

So, we have discussed a bit about roles and role based access control. It may seem enough for most, but it falls short (really short) for many cases. Before showing some examples, let's talk about attributes.

Attribute (according to [Wikipedia](https://en.wikipedia.org/wiki/Attribute_%28computing%29)) is a specification that defines a property. One may think about it as a value (stored in some repository), but that is just one of the possible implementation. It may be calculated in real time, cached, etc. It is a definition, that may be implemented in an infinite number of ways. That said, storing a value in the database will suit 90% of the use cases.

We know what is an attribute, but what things may have attributes? Any entity; that is where the qualitative difference with roles lies. Attributes may be associated to the user that is making an operation, to the object that the user tries to access, to the roles the user is associated, to the environment where the operation takes place (e.g. time of day), to other entities affected by the operation (e.g. when a user operates between two bank accounts, we may wish to check her relationship with the set of owners of both accounts).

With this understanding about attributes, I think it is easier to think about scenarios where RBAC is not enough:

- A user can only access an application during working hours
- Employees with a range of "director" may see and comment documents classified as "strategic" and "Draft".

If RBAC is properly implemented (as discussed earlier), much of the requirements related to ABAC is already in place.

#### Identity dimensions applied to ABAC

In a RBAC authorisation model, and given authorisation is a matter of security, roles and role management usually fit under the umbrella of security. In ABAC attributes are introduced into the equation, and in some cases the management of these attributes is not done by the same team as the one managing roles.

It is important to understand the reliability of the information we are using. This does not mean that only information managed by the security team may be used, or that there must be a validation of the information before using it. It is just a call to notice the three dimensions of the identities: completitude, reliability and fragmentation.

If the information is not "complete enough", it is difficult to set authorisation policies that make use of fields that may be missing.

If the information is not "reliable enough", it is difficult to use that information for security matters.

If the information is too fragmented, it may be impracticable to evaluate attributes and authorisation policies with the performance required.

### Is there room for MAC/DAC/ACL?

Yes. It may sound strange, after explaining RBAC and ABAC and explaining how these models cover extremely complex scenarios, and of course I am not going to argue that all authorisation should rely on a management done per-identity, but in some cases it is better and easier to do so.

If you have a pet, maybe you have to leave it to someone you trusted. In that case, either you bring your pet to that person's house, or you bring that person the keys to your home. In either case you are empowering one specific person because you trust her. That trust is affected by many factors, but most probably you would not trust any other person, even if that person has the same age, height, weight, professional experience, etc.

Attributes (and roles are just one type of attributes) are not all there is about an identity. We already discussed identity management requires accepting we are making tradeoffs and simplifications about identities. It is simply impossible to have *all* the knowledge about a person in a system.

Of course the use of an specific assignment of one user to an operation over an object (or any other form of DAC "policy") must retail the properties we have discussed: the action must be audited, the reason for the assignment must be recorded, depending on the criticality of the action it may not be allowed, etc.

Robert C. Martin in his book [Clean Architecture](https://www.amazon.es/Clean-Architecture-Craftsmans-Software-Structure/dp/0134494164/ref=sr_1_1?ie=UTF8&qid=1529923708) shows that software development paradigms (structured programming, object oriented programming, etc) are just restrictions to the original programming methods with direct access to hardware resources. In the same way I think authorisation models are restrictions over primitive identity management mechanisms, well deserved and well needed restrictions, but restrictions none the less.

## The reason for a complex authorisation model

When reading these explanations about an authorisation model, it may seem obvious to ask "Why should we take so much work into defining such a complex thing?", or "Why should we define the authorisation model as something so complex?".

There are two reasons for this:

- Complexity in the authorisation model definition reduces complexity in the identity management
- The authorisation model for a company is the framework for the authorisation models of the systems run in the company

The first statement is something we have seen many times, that a simpler authorisation model than needed may do the job, but at a cost of increasing the complexity exponentially. To illustrate the second statement, let's think about this scenario where a fictional system and a fictional company: the company uses an ACL for identity management and the system is based on groups (RBAC). It is possible to maintain an ACL with the association of users and resources, but the complexity grows exponentially.

[//]: # (XXX Insert a diagram showing the difference between ACL and RBAC)

## Propagation of the changes in the authorisation model and the attributes

In order to be able to make an appropriate security enforcement of the authorisation model, it is required to have updated information. Information propagation should happen online; if not immediately, at least as a best-effort.

It sounds simple, but when designing an implementation for the authorisation model, it is necessary to take into account what elements of information are going to be updated and when are these changes going to be taken into account.
