# Authentication, authorisation and access control

Regarding security, the most common uses for identities (other than information improvement, governance, auditing and the like) are authentication, authorisation and access control.

In order to perform these actions appropriately, identity information must be fresh and accessible. We have already discussed where this information should be and how to maintain it up-to-date, so we will not discuss much about these matters.

# Authentication

I'll try to depict the options for a good authentication schema for identities whether or not they are people.

This discussion is oblivious of the protocols used for the authentication.

## Classification

Authentication as the process of verifying an identity may happen in many forms. In order to make a simple discussion, let's make an almost classical grouping:

- **Something you know**: some kind of secret that no one can guess as it is within the internal memory of the entity.
- **Something you are**: something so intrinsically belonging to the entity that no one else can be.
- **Something you have**: some element that is tied or associated to the entity and cannot be stolen.
- **How you behave**: some patterns in the observable behaviour of the entity that cannot be reproduced. In this category I refer to the human-computer interaction as well as the higher level behaviour related to the, order of actions inside a web site, common business operations, etc.

## Extending the categories beyond people

In most cases this classification is associated to people, but they can also be associated to other kinds of entities that have to be authenticated, such as devices and services. I'd like to analyse other alternatives which enable a better authentication schema.

A part of defining that authentication schema is to properly think of the authentication methods as part of the authentication strategy, instead of side efforts to improve security.

### Something the service knows

This is the most common way of authenticating a service, by something only the service knows. This element of information may be something in a configuration file or inside the source code or a mix of both that seems to provide a higher level or security.

The secret may be presented as a bearer token, exchanged for an access token or used to create a cryptographic token. Anyway, the secret is used as the basis for the authentication process.

### Something the service is

It is not obvious to think of something that a service "is". It does not have biometric unique qualities; at least it does not have the "bio-" part of these qualities.

But a service is unique. There is a very specific code that the service runs and that generates the answers that the caller seeks. This code can be hashed and that hash is unique.

Having a code that hashes itself may be complicated, but nowadays services rarely run on their own. We have application servers, virtual machines, container orchestrators and many other components that host the services. These hosts are very appropriated to hash the services.

That hash (possibly signed) is a metric of the identity of the service. If "biometric" is not a suitable word for this, maybe "inert-metric" could fit.

### Something the service has

If it is difficult to think about a service as something that may have biometric characteristics, thinking about it as something with pockets may be even more difficult.

The thing is that this has happened in the past as something quite common. I'm referring to the "backpack" that had to be attached to a [serial](https://en.wikipedia.org/wiki/Serial_port) or [parallel port](https://en.wikipedia.org/wiki/Parallel_port) (yes I'm old and proud of it) in order for some software to work. If the software was installed, but the device was not attached to the right port, the software did not work.

That was a "something you have" authentication. And that same approach can be done too for IoT devices (nowadays it would be done via USB).

The contents in the attached item has something necessary for the correct authentication of the service. It may be some secret that is validated, some autonomous system that authenticates itself or some part of the code of the service that runs exclusively inside the item.

Another type of "something the service has" option is the use of an HSM. In this case, the service cannot authenticate without the access to the HSM. This access may happen as a local hardware associated to the machine the service runs on, or a network HSM (which carries its own authentication complications).

### How the service behaves

The behaviour of a service is something that can be defined, analysed, learnt and verified.

Of course we expect computer systems to behave as expected. That may be a double edged blade: it enables us to work with systems in a very trustworthy way, but it also makes us "lazy" regarding behaviour verification.

One example of learning the behaviour of a system is done by many [WAF (Web Application Firewall)](https://en.wikipedia.org/wiki/Web_application_firewall) vendors as well as database protection solutions. In both cases, the system observes inputs and outputs and defines a behaviour based on many parameters: set of characters used, number of rows returned per query, set of database operations, set of http endpoints and verbs, etc.

This information composes the expected behaviour of a system. Violating this behaviour makes this kind of authentication to fail.

## Authentication schema

An authentication schema is a definition of the possible authentication scenarios that are required in order to ensure that the authentication risk is low enough for the operations being requested.

These operations can be as broad as "application access", which would encompass any operation in an application, as narrow as "this specific operation", which would be valid for just a certain operation, or something in between like "financial operations of up to 20 Euros (with a sum per day of 100 Euros)".

### Selecting authentication mechanisms

Now that we know that humans and non-human identities can authenticate in many means, we have the playground to define a rich authentication schema.

In a communication, there are at least two entities that should be authenticated: sender and receiver (e.g. user and system). We may have more components, such as the mobile device, the web browser, the infrastructure where the service is deployed, etc. The security should be secure for all involved parties, and all components should be authenticated.

### Defining trustworthiness of each mechanism

Once we have defined the set of agents involved, we have to define the authentication mechanisms available for each of them. Once that set is defined, we have to choose which mechanisms are "valid" for our standards; a subtler categorisation would be to define a trustworthiness level.

For example: when we decide to use a user's source IP address during the authentication process, we should classify it as an authentication mechanism, define how trustworthy this information is and how much it impacts in the risk level of this authentication. Same goes for any other element of information for all the involved parties.

In opposition to the authentication mechanisms (that rise the trustworthiness of the authentication) there is the time. As time goes by, the trust in the authentication process decays. This decay may be immediate (authentication is valid for just one operation), have a defined expiry date (e.g. classical web sessions) or decay over time (e.g. with a formula that rises the risk level depending on the time since last operation or las authentication).

### Defining operation sets

Not all operations are created equal. We may decide that a corporative application for the employees to see their payrolls has much higher authentication requirements than another one to approve expenses. If we want to think about corporate applications as one single application with many subsets of operations, we have come to the operation sets.

In some cases we may decide to define specific operations that require specific authentications, such as financial operations signing.

### Classifying operation sets

No matter how we group operations, after the grouping we have to define a risk level associated to them. This risk level must be consistent with the levels defined for the authentications of the components involved in the communication.

For example: if we decide to create a set of operations called "mortgage read" (that binds together all the operations about present and past mortgages of the customer that do not modify them), and we decide that the user has to be authenticated "level 4", and the device must be authenticated "level 0", and the server must be authenticated "level 3", it is mandatory to define those levels and how to achieve them with a combination of the authentication mechanisms defined for the user, the device and the service.

### Continuous authentication

Some of the authentication mechanisms can (and possibly should) be used throughout the communication.

Some of these actions include the behaviour of the user, evaluating the interaction with the device in every step, some others include the use of the same keys in the SSL connection. The first is usually regarded as a continuous authentication mechanism and the second one is just taken for granted, but it is important to think about it as a continuous authentication mechanism, part of the authentication schema.

### Environmental factors

In addition to the specific authentication components, there are other factors that may affect the authentication processes.

These factors include the coincidence of certain patterns that have been associated to threads, such as the use of a vulnerable version of a browser, patterns in the cadence of interactions with the service, etc.

These environmental factors cover anything that may generate "suspicions" in the authentication, but are not strong enough as not to grant authentication.

The reaction to these factors may be as mild as to change the interaction flow (to discard the use of a bot), to request additional authentication (based on the rest of the authentication schema), to even reject access.

### Business behaviour

A behaviour authentication method that may be too soft to be classified as a mechanism is the business behaviour.

The business behaviour is the observed behaviour of a user at business level.

This includes the set of usual bank accounts the user transfers money to, the sequence of links the user clicks before deciding to make a transfer, the type of items the user buys, etc.

This behaviour is relevant to estimate the risk of the operation, and hence is relevant to decide the authentication level that should be requested from the user.

### Authenticating services in a microservice architecture

Once we have defined an authentication schema that includes authentication of services, implementing proper authentication in a microservice architecture is much more straightforward.

All service connection should require mutual authentication, encryption of the communications and possibly the sending of additional identities that may be relevant for the operation (such as the identity of the user performing the operation, and possibly the list of services that have been involved in the request).

## SSO (Single Sign On) as a flexible concept

The way that SSO is understood in most of the security literature is based on the use of some kind of token that enables the user access to different systems, all of which are adapted to that token. Possibly the most commonly used SSO schema is Kerberos.

From my point of view, SSO is a perception of the user. If there is some means to make the user sign in just once, we are into SSO. Of course security level must be maintained.

The difference in the approach resides in the set of tools to make SSO possible. In my approach, it is possible to use desktop applications to detect login screens and inject user credentials, transparently translate tokens of one type into tokens of a different type in order to accommodate systems that can be integrated via different SSO solutions.

Let's think about a user that wants to sign in once and use the following set of systems:

- A system that understands only Kerberos
- A system that can be integrated only via SAML
- A system that does note understands anything else than OIDC
- A desktop applications with proprietary user databases
- Operating system credentials
- Pre-boot authentication components for drive encryption

Convincing all involved vendors to evolve into one specific SSO technology is not a viable approach; instead of going that way, we need an external system (possibly associated to the IDM) that can understand and manage accesses to all these types of systems.

This SSO system requires many components; among others:

- Integration with Operating Systems (please note the plural) credential managers
- Integration with the IDM or central user repository to know when a password changes and when a user is disabled
- Integration with Web Browsers (once again, the plural) to detect login screens in web pages (including technologies such as Flash)
- Integration with Operating Systems window managers to detect login screens in desktop applications
- Integration with command line applications to detect login requests
- Credential management to manage different credentials (including passwords) for different systems
- Policy engine to define access control policies for different systems; not all applications are created equal and not all authentication requirements must be the same
- Token manager to manage exchange tokens of different protocols (Kerberos, SAML, OIDC, etc)
- Authentication manager to manage different authentication mechanisms:
  + Secrets, specially passwords
  + Biometric devices: fingerprints, facial recognition, iris analysis, etc
  + Behaviour: including human-computer interaction as well as higher level behaviour such as the order in which corporate applications are opened
  + Physical tokens: Smart Cards, RFID, NFC, Bluetooth devices, etc

The security considerations of a system that enables access to to many systems in so many ways are paramount. It is obvious that the SSO system must be though, but it is very important to understand how wide it is. The attack surface is really big and all parts of the system should be thoroughly checked.

## Biometric information storage

Storage of sensitive information is never a trivial matter, specially because this information (even encrypted) may be stolen. In the case of biometric information, it becomes a little bit trickier.

Storing information in a single place involves some risk. There have been enough data breaches about usernames and passwords as to understand that using the same password for a long time or for different systems is a risky practice.

One main difference between biometry and secrets is that you cannot change the first; this is both an advantage (you cannot "forget" the shape of your fingerprints) and a disadvantage: if your fingerprints are compromised (and you are leaving your fingerprints in a huge set of places every single day), it is difficult to "update your credentials".

Authentication information may be stored in a centralised server or in a distributed device. The first option may end up in huge data breaches of biometric information. The second one may become an issue for an specific user if the device is stolen.

Apart from all the security measures that can be applied to store information in trusted parts of the system, encryption of the information, and other measures, some part of the problem will remain: sensitive information is being stored in some place.

If this storage were not complication enough, sending biometric information through a network, even via an encrypted channel is forbidden by some policies. This makes it necessary to make a local processing of the biometric information prior to sending it (if at all).

Biometry is a complicated matter and it is very easy to do it wrong. Few standards have come to try and help interoperability and guide implementations. One of them is [BOPS](https://standards.ieee.org/findstds/standard/2410-2017.html). Among other matters, it addresses the storage of biometric information split between the device and the server, mitigating the risk of information theft.

## Authenticating a part of an identity

Even when it is not the most common scenario, there are cases where it is not necessary to have full identification of an identity in order to work with it (e.g. grant access to resources).

One of such cases is the buying of tobacco from an automatic machine. In this case, the machine does not need to know our identity, but it needs to be sure we are legally able to make the purchase. This case is solved in countries like Germany and Italy by presenting the national id card to the machine prior to using it as any other vending machine.

In these cases I always think about the following elements:

- An entity that does know the identity of the user: in the previous case, the government
- An identification token with the required information: the id card
- A mechanism to get the required information: the reader in the tobacco machine

In the case of the tobacco machine and the id card, the token contains much more information than the bare minimum to make the authentication, but we rely on the id reader to not track the rest of the information.

In some protocols such as SAML this scenario is well supported by using disposable identifiers and adding the set of claims that the service provider requires. In some other contexts, this may be a challenge.


TODO expand

- EAM
- Modifications to the requested operation (e.g. modifying sql queries)
- PAM
TODO Authorisation in microservice architectures (OIDC Vs XACML)
- Talk or share

- Authorisation management: based on "centralised control vs distribution and audit" section
  + Add comparison of OIDC (scopes based) Vs XACML (authorisation in the operation request)

## Actions resulting from the authorisation

TODO Resulting actions after the evaluation of an authorisation may be very diverse (ok/ko/whatever the application may require). The thin and grey line between security authorisation and business logic.

## Authorisation in a microservice architecture

TODO Expand

Microservice architecture are based on services calling each other. In this case, it is not the user directly calling the services and the set of components in the authentication is increased.

Let's suppose we have a proper authentication schema in place. We have defined what authentication mechanisms for each party are required for each invocation of each service.

There is a question non-trivial to answer in a microservice architecture: "Who makes the request?".

When a user requests goes to a "perimetral" service it is easy to know who is making the request: it is the user making the request.

When that same request goes "bouncing" from a service to another, the answer may not be so straightforward: is it the user making the request or is it the service making it? Is the user's desire to make this call or is it something that we decide on his own? What set of privileges should be checked: the ones of the user or the ones of the invoking service?
