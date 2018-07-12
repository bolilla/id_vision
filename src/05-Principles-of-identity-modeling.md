# Principles of identity modeling

- **Persons are the paramount element of identity systems**: Either directly or indirectly, identity systems relate to people. This makes it unavoidable to manage the information with the utmost respect to the ethical and regulatory concerns. From a practical perspective, even when the entity object of the work are not persons (e.g. an application for Role definition improving), the chances of missing the true point of the work are much higher if we remove people from the equation.

- **Model reality**: Do not force identities to accommodate your model. Expand your model to accommodate them.

- **Reading and reconciling over writing and controlling**: Watch the status of the identities and ask for information about why do they look the way they do. Do not try to impose restrictions until you understand the nature of the identities in a particular context.

- **A static repository schema is never enough**: It does not matter how much time you take into analysing and understanding current needs of a system. When a system goes live and reality knocks to the door of the system designers, options are making reality fit into your model (which is discussed in its own principle), or helping your model fit into the reality.

- **Entity relationships are the true source of value**: Just in the same way as characters in a novel are nothing but a description until they interact with the rest of the entities in the world, the value of entities in a system is nothing compared to the value of their relationships.

- **Identities change over time**: Change is one of the few constants in the universe. This is also true for entities. Creating a model or a system that thinks of entities as something that does not change over time is going to become a problem at some point. Even if the work relates to historical information, it is possible to find elements of information that enhance existing entities, or it may be our understanding of the entities that change. In either case, entity-related systems should acknowledge for entity updating.

- **Specific purpose for information elicitation**: Apart from regulatory-related needs (e.g. GDPR), this principle states the need for separating different uses of the identity information. In the same way as it is unethical to sell to third parties information that has been requested for sending company notifications, it is unethical to use for marketing purposes information that is elicited for fraud prevention (or vice versa).

- **Not all entities are concrete**: In security, it is common to use specific information about an identity as the sole component for identity systems (e.g. a user requires an account in order to access a system). In marketing it is much more common to work with profiles of customers instead of specific customers. This difference is not as much related to the context (security vs marketing) as it is related to the purpose of the work. Just as marketing often work with actual specific customers to understand reality and create better abstractions (profiles), it must be common practice to analyse concrete subjects (e.g. cybersecurity criminals) in order to create attacker profiles and use those profiles for planning actions and countermeasures. This is currently a trend in cybersecurity which should be encouraged.

## Some misconceptions about identity

I'd like to present some of the ideas that at some point seem to have been fixed in the collective mind about identities and their management.

- **Identities is something security team does on their own**: Even when most of the IAM (and CIAM) initiatives are conducted by the security team of the company, the use of identities transcends security and hence it should not be just "something that security people do". This idea comes from the heavy use of identity governance for authentication and authorisation.

- **Identities is something IT does on their own**: This idea about identity management is broader than thinking about it as a security matter, but still does not grasp the full scope of the identities. Information about people (specially customers) guide most of the business decisions we take; hence identities cannot remain an IT concern. It is business who must guide the way identities are modelled and used.

- **Identities are the elements of information used to login**: It is the other way around; the information used to make login belongs to identities, but it is not true that all the identities are somehow related to authentication, authorisation, access control and other security-related operations. For example, the information in marketing databases contain a good deal of identities, and that information is not directly used for logging in.

- **Silver bullet**: As it happens in many (should I say all?) disciplines, at some point some really good idea comes into scene, and that idea seems so good it will solve all the problems. One of the most interesting things I have learnt about this comes from [Gartner's hype cycle](https://www.gartner.com/technology/research/methodologies/hype-cycle.jsp); any emerging idea gets a high hype, then there is disillusionment, then we learn about what can we do with it, and in the end we use that thing for its purpose and stop trying to use it for anything unsuitable. Many things come to my mind as supposed silver bullets: "Role mining" (part of entitlement analytics), "Business rules" (automatic provisioning based on person information), "[ABAC](https://en.wikipedia.org/wiki/Attribute-based_access_control)", "[Dynamic roles](https://www.ibm.com/support/knowledgecenter/SSRMWJ_6.0.0.2/com.ibm.isim.doc_6.0.0.2/overview/cpt/cpt_ic_oview_featur_rolestaticdynamic.htm)", "[OIDC](https://en.wikipedia.org/wiki/OpenID_Connect)", "Fully centralised management of identities", single corporative directory, etc

- **One best solution**: Identities is a really complex topic. It tries to model an extremely complex world into as few abstractions as possible. If we were not so used to this kind of abstractions, we would think that modelling a person (with all her complexity) into a username (of up to 8 characters) and a password (with its uppercase and lower case letters) is some kind of joke. The "solutions" in identity management are always a tradeoff where you lose much in exchange for (some of) the value you seek, while trying to maintain complexity at a reasonable level.

- **Linear growth of complexity**: Identities take their value from relationships (e.g. user-role, person-person, etc). Relationships in a network (at least most of the ones related to identities) grow exponentially as the number of nodes grow linearly. This means the complexity of managing one thousand identities is not half complex as managing two thousand. It is way simpler. This also means that if identity modelling is not done right, the impact of generating "too many identities" is exponential to the number of identities created.

- **Single source of truth**: {Read with an epic voice (Morgan Freeman if possible)} This is the legend of the identity source of truth (a.k.a. fountain of youth). Some said it was a single source, some others said it was a composition of the HR information with the departmental spreadsheets for the contractors, some added some text files for the service accounts. The source was the beginning for all the identity knowledge. It was said to contain all the information that any IT systems could ever need. With the information in the source, plus a set of simple business rules, all the user accounts in the company could be [re-]created.{Epic voice off}. IMHO and based on my experience, there are many sources of truth for identities; regarding corporate accounts (e.g. employees, contractors), it is possible to have a kickstart with the information from HR plus some excels plus some business rules, but they are absolutely not enough to make a whole identity management system for two reasons: the modelling of identities leaves a huge amount of information out of the picture (specially operational information), and the scope of each source (yes, there are many) is too narrow (e.g. employees, devices, customers, prospects, threats) because the department creating each source of truth is focused on one single type of identities. Trying to create a single source of truth is forging a silver bullet.