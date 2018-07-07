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


TODO expand
- EAM
- Modifications to the requested operation (e.g. modifying sql queries)
- SSO and flexibility in this concept (tokens vs browser plugins). It is mandatory to do it as well as possible.
- PAM
TODO Authorisation in microservice architectures (OIDC Vs XACML)
- Continuous authentication and user behaviour based on business information
- Enough authentication - Risk based authentication and dynamic evaluation of context to set thresholds
- Storing biometric information in two places (device and server as BOPS2 says)
- authenticating a member of a group
- Authenticating an identity and stating just part of the attributes (eg tobacco machines)
- Talk or share

- Authorisation management: based on "centralised control vs distribution and audit" section
  + Add comparison of OIDC (scopes based) Vs XACML (authorisation in the operation request)

## Actions resulting from the authorisation

TODO Resulting actions after the evaluation of an authorisation may be very diverse (ok/ko/whatever the application may require). The thin and grey line between security authorisation and business logic.
