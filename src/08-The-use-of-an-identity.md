# The use of an identity

We know what is an identity, but in order to expand its meaning and its qualities, it is imperative to understand what are we going to do with it.

Even when the actual objective of the work with identities belongs to the worker, and this document cannot cover them all, let's classify operations in five different categories:

- Obtaining identity information
- Identity information storing and making available
- Identity lifecycle management
- Identity information improvement
- Identity information retrieval for actual company uses

Only one of the five categories is directly related to getting value from the identity information we have. May be that is one of the reasons why it is sometimes so difficult to use the information when it is needed: because it was not sufficiently elicitated, because it is not properly stored or not properly available, because it had not been updated, or because the information is too raw to make use of it.

## Identity management processes

Here we will expand each of the identity use categories and provide examples. This section should also help making it clear why concerns are so different in each of the categories.

### Obtaining identity information

Elicitation of identity information from sources external to the company. There are different ways of getting identity information. The following are just a few:

- **User self-registration**: Enabling users to register into our services
- **"Bankization"**: User goes through the classical process of going into a bank office, providing ID, etc in order to become a customer
- **Online registration**: Similar to the previous "bankization" process, but happening online
- **Prospect database**: In many cases a company buys a prospect database: a set of possible customers with some specific characteristics that make them prone to buying some company services or products
- **User behavior collection**: While a user uses our services there is much information we may gather (of course while observing regulations). This behaviour has two components: business information (which is the set of services that the user uses most, etc), and technical information (source IP address, used web browser, typing cadence, etc).
- **Merges**: During company merges, there is an addition to the set of identities managed by the system. This includes employees, customers and all related information.

All the information that comes into the company must be stored and made available.

[//]: # (XXX Insert a diagram explaining the categories)

### Identity information storing and making available

Identity information is quite heterogeneous from a storage POV. The requirements for reading, updating and navigating identity information are extremely different depending on the use they are going to have.

From an IT architecture perspective, we probably want to expose identities in a versatile way. Instead of providing access to the repositories via ODBC, LDAP or some other repository specific interface, we may prefer a wrapping for most commonly used identity operations. Even if we do not plan to change the repository technology itself (LDAP looks like a long term option for identity storage), it allows changing the internal structure (which is something that will surely happen at some point). [SCIM2](http://www.simplecloud.info/) may be a good starting point for this wrapping interface.

[//]: # (XXX Insert a diagram showing the Dependency inversion principle)

### Identity lifecycle management

Lifecycle management is not as simple as implementing a CRUD interface around an identity repository. It goes much further than that.

Since identity information is subject to many regulations (e.g. GDPR), and it is used throughout the whole organisation, the lifecycle management is very complex. It is so complex I would divide it in two layers:

- Lifecycle management of the identity repositories
- Lifecycle management of the identities in each repository

In order to have come control (centralised or not) over identity information, it is mandatory to know where are identities stored in the company. This seems to be easy, but it goes into the lands of shadow IT, department databases, application database exports, etc.

In this case I honestly think the typical IAM initiatives (the ones related to employee and contractor identities) have done a good job over the years and there is usually a good census about corporate applications and repositories for these identities and their relationships.

Regarding customer information and other identities, since there is no equivalent to the IDM (Identity Manager), I am not sure there is a good centralised census.

A complex part of the lifecycle management regards the authorisation processes involved in the evolution of the privileges of a user. The modifications in the authorisation model, along with the requests, approvals, auditing, etc. These processes are usually high level business processes that involve a great number of actors; its definition and implementation is not easy or fast at all. I would suggest to begin easy and go on improving the system.

Another complex lifecycle management operations is the recertification process (which has several implications regarding authorisation). In this process the company confirms that the employees and contractors have the right set of privileges to perform their job. This labor not only requires the analysis of the individual identities for employees and contractors, but also an analysis of the privileges provided by automatic means.

### Identity information improvement

This set of processes are composed by the analysis an enrichment of identity information.

Different final users of the identity information will need different types of identity analysis and improvements. For fraud analysis, the kind of enrichment of information will be very different than for authorisation.

I will show three different scenarios for identity enhancement that will provide higher value to three different uses of the identity information.

- **Connections between known fraudsters**: In order to have improved detection of fraudsters, we may want to analyse relationships between know identities associated to fraud. We may think that two persons living on the same address may both be fraudsters.
- **Geolocation of a customer**: After having received user connections for a long period of time, we may decide that any country from where the user has connected at least 5 times is a "usual country" and hence we should not request a second factor of authentication when the user connects from these countries.
- **Authorisation model improvement**: At some point we may decide that we have too many roles in the company and we want to have fewer to ease the administration. This involves an analysis of the current identity information in order to come out with a better arrangement for the roles and permissions.

### Identity information retrieval for actual company uses

This is the category where most eyes are set upon: extracting actual value from the identity information.

In this category we have the common uses of identities, such as marketing campaigns and authentication and authorisation of user actions, but we also have some less usual processes, like providing information about an identity to the owner of such identity, sending identity information to a third party to receive some valuable product or service (e.g. credit card printing), auditing identity information to prove compliance with regulatory constraints.

It is this final use of the identity information the main element to guide the decisions in the identity information storing and making available processes.

[//]: # (XXX Exemplify uses of information)

## IDM for employees, contractors, consumers and customers

Now that we know a little bit about identity processes, let's have a look at the two common tools that help in the management.

### The use of an Identity Manager (IDM)

Many of the requirements regarding identity information management involve synchronisation of information across multiple sources. We have already discussed the concept of identity federation, and how it goes beyond authentication and single sign on.

Unfortunately, identity federation cannot easily solve most of the problems associated to multiple identity processes (please remember, there is no silver bullet), specially when there is a complex authorisation model in place.

For cases where identity information has to be shared among different repositories, and there must be some kind of "higher order" identity, that contains information about authorisation that transcends any single repository in the company, that's the place for an IDM.

IDMs are commonly used to store high level information about identities, along with enterprise roles and some other authorisation information. In most cases, before using this identity information, it has to travel to a different system, where the identity information is consumed locally. This travel is called provisioning. The travel in the other way around is the reconciliation.

As we have already discussed provisioning and reconciliation along with auditing while speaking about centralised control; I am introducing the IDM here because it is the processes about identity that explains its need.

#### IDM as an application authorisation repository

IDMs provide a complex authorisation model, which should cover most of the authorisation scenarios in a company. This ability makes the IDM itself an interesting option to store and manage the entitlements local for an application. As we are talking about complex authorisation scenarios, this kind of system regards specially to employees and contractors.

It is not very un common, but it is a model worth exploring to use the IDM itself as a replacement for a local identity database or a local identity directory.

It provides (in addition to the authorisation model) a pre-provision of all the identities in the company, an immediate update of much of the identity information, etc. On the other hand, managing one application in such a complex component as an IDM may be overkill in many cases.

### CIAM identity manager

If IDM relates to employees and contractors, CIAM IDMs relates to consumer and customer identities.

Most of the identity processes are different in internal IAM and CIAM, but both share much of the security-related use of the information: user profiling, authentication, authorisation and access control.

In the case of CIAM there is no interest (or not much) on using a complex authorisation model, there is on the contrary a huge attention to the consent management, as well as federation of identities with external sources (e.g. social networks) and analytics (from a security point of view, but also from a marketing point of view).

### Convergence of identity management for internal and external users

Ambitious as this personal vision may be, I still cannot conceive in the short term any commercial tools that address both customers and employees use cases in an integrated manner.

But the need is already there; if we want to have a truly global and unified sight of all the identities that are related to the company, it is mandatory to integrate the information for IAM and CIAM (without overlooking devices, accounts and the rest of identities that are involved).
