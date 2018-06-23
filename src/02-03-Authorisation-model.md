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

TODO continue

### Is there room for MAC/DAC/ACL?

Yes; specially for DAC. TODO expand.

## Information about entitlements of a system inside the an IDM (corporate or specific for the application)

## Coherence in the authorisation model definition, implementation and application

TOD expand Implementing ABAC when the model is RBAC makes no sense

TODO Explain why it is necessary to have a complex authorisation model: because it is the framework, just as the law is the framework and not all articles apply to all activities all of the time. We should use the simplest subset of the model in every case. We should simplify it as much as possible, but no further (I think it is based on Einstein's quote).

TODO Authorisation in microservice architectures (OIDC Vs XACML)

TODO Segregation of duties based on entitlement information or entitlement-system or system-system to prevent problems when roles change. Possibly relate this to dependency diagrams in "Clean architecture".

TODO Discussion about Identity Manager

TODO Changes in the authorisation model must be propagated immediately
