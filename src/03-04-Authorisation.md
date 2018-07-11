# Authorisation

Given we have already discussed (long and hard) about authorisation model, let's think about authorisation as a "simple" mean of applying that model.

## Where authorisation takes place

There are many places where authorisation can take place. For a comprehensive analysis of these options, there is a good document from Gartner called [Decision Point for Selecting Runtime Authorization Architecture Patterns](https://www.gartner.com/doc/3310917).

In this document we will explore just enough to discuss EAM (Externalised Authorisation Management).

### Within the service

Authorisation has classically happened within the application. It is some code inside the application the one responsible for checking that the user belongs to the admin group, that the resource belongs to the logged user and so on.

This is very convenient from the developer point of view, but haves two severe constraints that do not:

- It is not easy to analyse: it is necessary to go into the source code in order to understand the policy
- It is not easy to change: it is only the application developers who may make modifications to the policy

These two constrains (which are not the only ones, but IMHO are the most important ones) make the case for EAM.

### Before the service

In this model, there is some component that intercepts the request to the service, makes the evaluation of the authorisation and forwards (if the evaluation grants it) the request to the service.

This model, as uses an specific component with independent governance from the service, removes the constraints in the previous section, but creates a new one: the result of the evaluation is not business related.

We may decide that the request should be processed or not processed at all, but it is not possible to take other actions without deep knowledge of the service business.

### Next to the service

In this model, all requests go into the service without authorisation validation. It is the service the one that makes the request to the authorisation component and takes action on the response.

For example, a money transfer service may reject or accept the operation as a result of the authorisation, but it could also decide to mark the operation as "suspicious" or "risky" or delay the operation actual execution while informing it is done, or making any other business-related operation. These operations even when they may be related to the authorisation (which is a security concern), are business dependant, and can only be properly managed by business, not security.

The improvement of this model over the previous one is that the actions associated to the authorisation may be specific to the business of the service; the restriction that it generates is that deciding whether or not to call the authorisation module at all is a decision of the service.

### Adding models external models

Of course it is possible to make two authorisation evaluations: one before the actual call to the service, and another one from within the service.

This approach solves some of the restrictions of the two models (the decision of calling a part of the authorisation is still dependant of the service), and may create a new one: an increment in the set of steps and hence cause an impact in performance.

## The result of the authorisation

We have already talked about different kind of actions and security actions when discussing where does the authorisation take place.

To summarise and add to the list, we have the following options as a resulting action to the authorisarion evaluation:

- Security action: accept, reject, forward the request to the service, answer with some error code, etc
- Business action: actions that only the service can take and depend on the logic of the service
- Operation modifications: these actions are yet to be discussed, and include changes to the request that the service processes in order to be compliant with authorisation restrictions

### Operation modifications

In some cases, a request made by a user must be narrowed in order to be processed.

An example of this is a request to remove everything sent to a cloud storage system. All of us expect the service to remove the information of this user, and not the information from the rest of the users of the system, even when the user has requested "everything".

The transformation from "everyting" to "everything owned by this user" is transparent to the user making the request, but is compulsory to implement it and to do it well.

If the authorisation is complicated (and we have already seen how complicated it may get), transforming requests is more complex. For example, if the set of elements that the user may delete includes the resources created by the user, plus the resources he's been given administrative rights to, plus the resources created under the hierarchy of resources created by him, etc. In such a case, the modification of the semantics is harder.

If done properly, the authorisation model should guide the modification of the requests, and these modifications could happen before the request actually comes into the service processing the request.

## Getting the information for the aurhorisation

The information for the authorisation has to be gathered at some point in time.

This information may be gathered when the initial authentication process is made, when the first request is made or when the action is being processed.

In addition to the considerations of (Lazy evaluation)[https://en.wikipedia.org/wiki/Lazy_evaluation], the authorisation has two additional constraints that must be taken into account:

- The information should be as fresh as possible (with different freshness thresholds for different elements of information). If user information is gathered at login and it changes within a session lifespan, the authorisation process may take wrong decisions.
- The set of information required for an evaluation may be unknown. If the user logs into an application and the information of this user is gathered within that scope, if the underlying services call other services, chances are some authorisation information may be missing.

The first restriction may or may not be an issue depending on the duration of the sessions; if the session is too long, authorisation may be impacted.

The second restriction is a problem in microservice architectures. Either we have full knowledge at login time about the set of attributes that are going to be used throughout all requests, or we get "all the information" just in case. The first option is really complicated; the second option may have a huge performance impact since all requests will have a lot of information about the calling identity (or identities).

### Two different approaches: OIDC (OpenID Connect) Vs XACML (eXtensible Access Control Markup Language)

I am not going to discuss protocols in this document, but it is important to note the differences in the approaches of these two protocols.

OIDC (as OAuth) is based on scopes, which can represent [more or less] anything related to claims and authorisation. These scopes are requested at login and are discussed with the service granting the tokens. As OIDC tokens can be   self-contained, the token used to access can include the scopes.

XACML is based on evaluating authorisation by requesting identity information to external sources during the access control.

The first approach is great when the scope of the system is well defined and the governance can be done in a centralised way. The second approach enables distributed management of the authorisation and "Just in time" evaluation of the required elements of information.

My opinion is to combine both approaches, so general authorisation information is set at login, and information specific to a service is retrieved when it is needed.

## Improving the time to evaluate authorisation

It is attributed to Einstein defining insanity as "Doing the same thing over and over again and expecting different results".

Getting the same elements of information for authorisation and evaluating them once and again may not be insanity, but will certainly result in a performance impact.

There are two main ways to improve the time for these evaluations:

- Cache the authorisation request
- Cache the identity attributes

### Cahing the authorisation request

The evaluation of two authorisation requests with the same values (including the applied policy set) should result in the same result. The question is "what does two authorisation requests the same?"

Of course, if all attributes involved in a certain request are the same, it should be obvious that the result should be the same. This is the easy one (or not?).

Of course, if the attributes that change are not evaluated in the policies, the result should be the same. This is easy too.

What happens if the change is subtle?

- If the change is the source IP address, it may imply a different geolocation, or the use of a round-robin in a gateway
- If the change is the timestamp of the request, a difference in just few milliseconds may result in changing the time when a market is closed... or may be not.

For a "similarity check" to be successful, it is required to understand the semantics of the business and the impact of each and every attribute change.

Let's go back to the "all parameters are the same" case. It is often thought that actions are [idempotent](https://en.wikipedia.org/wiki/Idempotence), but they are not in many cases. Being able to get a loan for one million euros does not mean being able to get a second (or a third) one. Once again, it is important to understand the business in order to cache authorisation requests.

### Cahing identity attributes

There are many questions relevant to cache an attribute: May it change? How often? How relevant is the attribute for the authorisation? How critical would it be if the attribute is not up-to-date?

It is required to balance the answer to all these questions in order to have a good caching strategy.

As it happens in the case of caching authorisations, it is mandatory to understand the business of the authorisation and the business of the service associated to the authorisation in order to make good decisions about caching.

### Cache management

All information in the caches for authorisation should have an expiry date. Even when it is arguable in a theoretical way that some evaluations will never change, in most cases it is practical to spend some milliseconds (or even seconds) to make an evaluation instead of relying on old data.

The availability of the information in the cache is very difficult to achieve, as the information is diverse and the user may happen at different points. I would try a best-effort cache information sharing that could impact performance but not service availability. If an element of information (that has already been used) cannot be retrieved from the cache (either because it has not been propagated yet or because it has been deleted), it should be requested to the proper source.

Of course all cache management considerations such as refreshing expiry dates of accessed records, volatility of information, etc apply.

## Carrying identity information

Microservice architecture are based on services calling each other. In this case, it is not the user directly calling the services and the set of components in the authentication is increased.

Let's suppose we have a proper authentication schema in place, an authorisation model we feel comfortable with, with all the means to get identity attributes and all the authentication mechanisms are set in place. Even in this case in a microservice architecture, there is a question with a non-trivial answer: "Who makes the request?".

When a user requests goes to a "perimetral" service it is easy to know who is making the request: it is the user making the request.

When that same request goes "bouncing" from a service to another, the answer may not be so straightforward: is it the user making the request or is it the service making it? Is the user's desire to make this call or is it something that we decide on his own? What set of privileges should be checked: the ones of the user or the ones of the invoking service?

Unlike other disjunctives discussed in this document, the carrying of identity information across a microservice architecture must be coherent throughout all the services. Hence it is a global decision that affects all the services.

On one side of the options is the simplest one: it is the service calling, so we remove all other identities from the request. On the other side is the most complicated: we stack the identities of all involved parties, including the requesting user (if any) plus the identities of all services involved.

Possibly the equilibrium involves the use of an arbitrary set of identities with some tagging for the role they play in the operation such as "initiator", "impersonated", etc.

## The thin line between business and security

Authorisation is one of those concepts that are perfectly clear for people with different backgrounds. Unfortunately, their understanding is different and they usually do not know it. Authorisation from a business point of view relates to business logic; it has to do with account balance, solvency, etc. Authorisation from a security point of view relates to user profile, privileges, etc.

It is fun to speak with security people and say things like these: Authorisation is a matter of security; it is one of the things that maintains the company safe. For example, if we don't check the account balance before authorising a money retrieval, a customer could steal money from us. Hence, a security policy should be placed to prevent this from happening.

I know many security professionals who accept this set of statements without blinking. There are others who bring into context business policies, that may (or may not) grant a user to withdraw money as a loan; as a service that the company provides.

Checking the balance of an account and rejecting an operation when there is not enough money is a policy that could be regarded as security. Calculating a credit score seems closer to business. Evolving this policy as business requirements change is definitely something that cannot be done by security on their own.

Deciding which policies should be lead security is difficult, but the responsibility of the maintenance of those policies should help.
