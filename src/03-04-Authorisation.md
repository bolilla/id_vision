# Authorisation

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
