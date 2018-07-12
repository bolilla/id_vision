# Digital Identity in banking: a personal vision

This document contains my own personal vision about digital identities, its management, its value and its use in a banking environment.

I have chosen banking sector because I think there is a "perfect storm" coming in that sector regarding identities: the banking model is changing, the relationship with customers and employees are changing, the normative framework is changing and the threats are changing too. All these fronts must be tackled sooner rather than later, and I think focus on identities may provide a fresh view to set company strategies.

It shows a situation that may be far away from current status for most companies at the moment, and that is one of the purposes of this work. Why would anyone write (or read) a vision that is close to current reality?

# Executive summary

Identities are inherently complex because are abstractions of extremely complex entities (people mostly). There is no right solution to most problems; there are many tradeoffs to understand and decisions to make.

Understanding each of the aspects of the identities enables the definition of a corporative long term vision of the identities, and that vision shall guide the efforts of the company.

The relationship of the company with the community of identity professionals and the internal identity team is crucial for the success of identity initiatives.

# Some concepts about identity

- **ABAC (Attribute Based Access Control)**: Authorisation model based on the evaluation of custom policies based on arbitrary attributes.

- **Access Control**: Act of restricting or allowing access to an operation. In most cases it is the implementation of the decision taking during the authorisation process.

- **Account**: a record of an identity in a system. Enables the access to the actions performed by the system.

- **Authentication**: Process of verifying an identity, normally used in order to grant access to a system or to perform an operation.

- **Authorisation**: Process of deciding whether an operation should be allowed or not, and in some cases what action should be taken.

- **Business rules**: Automatic rules for identity management and provisioning based on identity information.

- **CIAM (Customer Identity and Access Management)**: The discipline that works in detail with the with identities of customers and consumers.

- **Connector**: Part of an IDM that understands a managed system and is in charge of the semantical mapping and the communication between the IDM and the managed system.

- **Dynamic groups/roles**: Groups defined by a filter. Instead of associating users to groups, the association is calculated online based on user's attributes.

- **Governance**: Identity processes related to the analysis of the identity information and its improvement. It is specially relevant for employees and contractors and the authorisation information management.

- **IAM (Identity and Access Management)**: The discipline that works with identities, specially with the security-related aspects. Classically it has focused mostly on user accounts and their privileges.

- **IDM (Identity Manager)**: Piece of software whose purpose is the storage of top-level identities for employees and contractors, as well as the management of the authorisation information from a centralised point. It communicates with the rest of the systems via a hierarchical relationship and the processes of provisioning (to push information) and reconciliation (to get information).

- **Identification**: Providing information about an identity (normally oneself). Normally done in conjunction with the authentication.

- **Identity Federation**: Linking information about an identity from different sources ([according to wikipedia](https://en.wikipedia.org/wiki/Federated_identity)). This term is used extensively in the context of SSO, but it is not exclusive to it. The value of linking identity information from different sources goes much beyond an easy login.

- **MAC (Mandatory Access Control) / DAC (Discretionary Access Control) / ACL (Access Control Lists)**: Used interchangeably in this document. The three describe authorisation models where the management is done on a case-per-case basis; without grouping subjects.

- **OAuth**: Open standard for access delegation. Most recent version is 2.0, which is the basis for OIDC.

- **OIDC (OpenID Connect)**: Identity layer on top of OAuth 2.0; enhances OAuth by providing identity verification as well as basic profile information of the authenticated identity.

- **Orphan Account**: account that is not known to be tied to any person.

- **PAM (Privileged Access Management)**: Part of identity management that relates to the management and use of accounts that accumulate much privileges and (in some cases) are not strictly associated to a person performing the operations.

- **Privileged Account**: account with special (administrative) privileges. May be associated to specific person or may be anonymous.

- **Provisioning**: Act of pushing identity information from a centralised source (normally IDM) into other identity repositories.

- **RBAC (Role Based Access Control)**: Authorisation model based on the use of the specific attribute roles.

- **Reconciliation**: Act of retrieving identity information from distributed systems into a centralised point (normally an IDM).

- **SSO (Single Sign-On)**: I'll not follow the standard definition and use this: the ability of different systems with loose coupling to authenticate user actions while requiring just one user interaction to log in.

- **XACML (eXtensible Access Control Modelling Language)**: Standard based on XML that provides a detailed definition of the ABAC model.
