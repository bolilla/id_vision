# Identity-classification

The typical classification of identities in IAM usually refers to the distinctions between employees, contractors and customers; in some cases service accounts receive some attention, and so may do anonymous privileged accounts (e.g. root accounts in unix systems).

This vision tries to go beyond this classification and expands identity considerations to a broader context than accounts. Accounts are the means that IT systems use to associate operations to identities. Identities transcend accounts, have a broader scope and do not have to be associated to any account in any IT system in the company.

## The birth of an identity

Identities are created in may different ways. In most cases they are derived from other identity information.

These are the most common ways of an identity to be created.

### Enrolled identity
At some point, the information of an account comes into the scope of the organisation. It may happen because of some typist (or a person) introduces the information by hand, or because it is imported from another system. This is the beginning of the identity journey in the organisation.

### Integrated or Aggregated
Identity information merged from the aggregation of different sources of information. e.g. crossing employee records and customer records, crossing information about concrete accounts and privileges in different systems. These identities are mostly used out of IAM discipline; within IAM their use helps in the optimisation of the identity governance.

It is crucial to have some means to relate identities in different sources of information (e.g. well chosen and common identifiers).

### Fragmented
Identity information where the scope is well defined by a set of elements of information, but where the system is prepared to work with incomplete information. e.g. Identities of a system where the scope of the records is name, email and telephone, and accepts that some identities have just one of the three fields populated. I have seen little use of these identities in the classical IAM realm; their use for marketing, fraud analysis, etc is doubtless.

### Profiled
Profile defined from different sources of information. e.g. hacker profile definition, regulator psychological profile, market segmentation, etc. I think this kind of identity is extremely underused in IAM; it would have huge impact in many areas, such as identity governance.

### Projected
Identity created with a subset of the information about another identity. e.g. email account created based on the information in HR system. It is common to project the identity information in a system in order to create an identity in a different system. As a matter of fact, this is the way in which most IDMs strategies work: An account is created based on the information in another system (e.g. centralised IDM, HR database) and additional information is added afterwards.

### Inferred
Inferring an identity consists on creating an identity based on the information of different sources that suggest that this identity should be created. This is common in the processes related to role rationalisation, where roles are created, merged, etc in order to have a better model for identity governance.

The true source of information for identity inferring is the relationships of the identities between themselves.

## Identity dimensions

In order to understand the nature of our identities, we have to know the dimensions where they can be measured.

These dimensions (along with the former classification) constitute the basis that will guide us in the use of the identities.

Of course the values of the same identity for different uses may differ. An identity that may be more than enough for the authentication of a user because it has username and password, may be not enough for a marketing campaign because it lacks email address.

### Completitude

The classification of a identity in this dimension is made by answering the question "Does the identity have all the elements of information that I need?".

### Reliability

There are many questions to evaluate this dimension: "Does this information come from a source that I trust?", "Has it been altered?", "Is the information up to date?", etc.

### Fragmentation

This dimension deals mostly with the value of the information in the identity. The more identities I have merged or accessed (possibly from different sources), the more value I have been able to infuse into this identity.

## Where are the accounts?

If you have read this section up to this point you may be wondering "Where are the accounts, the roles, the groups, the entitlements, etc?". The answer is simple: "All of them are identities.".

I'll give some examples: an Active Directory account that is created because of some automatic process in the IDM is a projected identity. Some groups in Active Directory (which have been typed by some application owner) are enrolled identities. The information provided to a user that comes from different sources (e.g. an aggregate balance of a customers who owns different kinds of assets) is an integrated identity.

The vision in this document does not ignore identities implemented as system accounts; it tries to cover a broader scope. For example, the identity information that is stored in the HR database constitute many identities; even when that information (while it is just stored in that database) cannot be used to "log in" a system.
