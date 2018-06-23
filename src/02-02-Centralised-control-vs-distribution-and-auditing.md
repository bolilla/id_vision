# About centralised control and how it compares to distributed management and auditing

It is very common to discuss governance in terms of centralisation vs distribution. Instead of offering a simple answer, I'd like to provide the dimensions that should be analysed for decision making.

In this particular case, I am referring to identities and their information, but the same approach could be used for other scenarios.

Even when there may be a grey scale between a fully centrally controlled system and a fully distributed one, I'll analyse them as complete alternatives.

## Who is the owner of the information?

In this context ownership I means liability. Another way of stating this question is: Who is going to suffer when a mistake is made regarding this information. The mistake will always happen at some point; it may be disclosure, failing keeping the information to update, lack of availability, etc. Suffering may mean different things: paying a fee for violating a regulation, managing sues from upset customers, delaying a commitment, etc.

If the owner of the information is an specific actor, probably the management of that information could be made in a centralised way. If some of the liabilities refer to different actors, we probably should have a shared control over the information.

## Who is in contact with reality?

One of the best books I have read about complexity in organisations (and at this point I hope you're with me into believing identity is a complex matter) is "Organize for Complexity: How to Get Life Back Into Work to Build the High-Performance Organization" by Niels Pflaeging ([this](https://www.amazon.com/Organize-Complexity-High-Performance-Organization-Publishing/dp/0991537602)). One of its principles is that big organisations end up having a group of people in contact with reality and dealing with it, and a group of people afar from reality and managing the organisation.

Best decisions are made by people who know reality. Simple as this may sound, it is astounding the number of situations and organisations where this principle is violated.

One of the twelve [agile principles](http://agilemanifesto.org/principles.html) says "The best architectures, requirements, and designs emerge from self-organizing teams.". This happens because the team who is implementing a software is very much into reality. That reality (of course, combined with proper education and experience) is key in the decision making process.

In identity management, it is quite common to have a centralised team making decisions about the authorisation related to identities throughout the organisation. Obviously that team does not have deep knowledge about the reality in every system these identities are used into. Does this mean this team cannot provide value to the identity management processes? No.

Reality has a tendency to being complex and multidimensional. In most cases, identities are related to many external reality dimensions. Let's list a very few of the "realities" for the management of the authorisation-related information about identities:

- **Incompatible privileges within an application**: we have to make sure no single person has the ability to issue bills and accept them.

- **Incompatible privileges between applications**: no user of an application should be administrator of the underlaying database.

- **Recertification**: external regulatory constraints makes it compulsory to review the privileges an employee has and validate all of them are needed in order for her to perform her job.

- **Enabling privileged access**: some systems do not [easily] accept user management for some privileged operations. These systems still need to be managed and in order to do so, some anonymous credentials must be used.

- **The organisation has to enable the right to be forgotten**: the organisation has to manage the operations required to ensure the right to be forgotten is implemented throughout the company information records.

These four portions of reality may be managed by four different teams within an organisation: the first one can only be managed by someone with very deep knowledge about the application (possibly the team administering the application); the second one cannot be managed unless there is a team with broader sight than one single system (here comes the need for an identity team); the third one must be managed by whomever knows what the employee does to service the organisation (possibly with help from the identity team); the fourth one can be managed on a per-team basis with many gaps regarding audit, or may be managed in collaboration with a team that sets into place a PAM (Privileged Access Management) tool; the fifth requires much knowledge about the organisation, their systems and their management, which can only be achieved with cross and specific teams.

As we can see, much of the management cannot be made without the help of a team that transcends one single IT system. That team is what I'll call the Identity team.

### Self service within an organisation and between organisations

One of the contexts where we feel very well suited regarding identity (and privilege) management is in the self-service context.

What mesmerises me about self-service management is the perception of freedom. For me it looks like a puppet show where the threads are so thin (yet strong) that they are not seen by the public. When a system enables you to make the decisions about the authorisation, it makes so under a very strict rules that narrow the ability of the user in an extreme way. It gives the user an extremely small realm and makes her think she is sovereign of the whole world.

There are two important (and broad) requirements for a "self-service" implementation to be successful:

- **The set of administration rules must be very tight**: What is the scope of the user must be very well designed so that she cannot go out of it and still retain all the freedom she needs.

- **The responsibilities for the management are completely segregated**: The liability of the service provider is zero (or next to zero). I cannot think about suing google if I happen to make public a private document about my health. I cannot do it [because of the dreaded EULA and] because it has been me who has made the mistake.

When we are talking about different organisations, it is [relatively] easy to satisfy both requirements; when the service provider and the user belong to the same organisation, there is more room for shortcuts; for not-so-tight administration rules and not-so-complete segregation of responsibilities.

I personally believe self-serviced administration of identity information (authorisation-related) is one of the many solutions that may balance the tradeoffs of identity management in many cases, but it is not a silver bullet. I don't hope it to work in all contexts within an acceptable level of effort and time to be properly implemented.

## Relevance over agility

This tradeoff refers to the balance between the possible consequences of a proper management of the information versus the need to manage it in a speedy way.

If the information is truly relevant (e.g. it enables financial fraud or exposes the company to regulatory sanctions), speeding up the information management process may be not so important, and a centralised management system may be used.

If the information is not extremely relevant for the company (e.g. updating the physical address of a customer), the operations may be done in a distributed way.

### The cost of a mistake

One of the tradeoffs to make in identity management regards the cost of an error, and who pays for the error.

In case an error is cheap and if it is not the company who suffers the consequences, we will not pay as much attention as if the error hurts deeply the company.

Paying attention to the possibility of a mistake in the identity information may mean different things:

- **Setting a dedicated team to the task**: we can assume the user is going to make mistakes, so we prefer to dedicate a professional team to the task. Who may make mistakes too, but hopefully they'll happen seldom.

- **Implementing automatic controls**: whenever possible (and feasible), we can implement automatic checks to ensure the information being managed is correct. We will not spend the same amount of resources when checking a target account number for a money transfer (where we may check whether it is blacklisted or not), than when processing an online enrolment of a new bank customer (where we may check whether she is customer of a different bank, confirm the postal address, double check the identification card, etc).

- **Implementing manual controls**: independently of whether we have implemented any number of automatic controls, we decide the information has to be manually checked. The checker may be a professional with specific knowledge about the business (e.g. we must make sure proper deletion of all the records of a person who has exercised her right to be forgotten), or about operations (e.g. we request the boss of the employee who requests access to a document, to verify it is required for her to perform her job).

A little note about the use of the word mistake in this context: it is no different for me that a mistake happens on purpose or not. I understand the risk of a mistake may be calculated (in a very basic way) as the impact of the mistake times the probability of it happening. If some kind of "mistake" can be triggered by internal fraud, of course it may have a higher chance of happening, a higher impact and hence it should have a higher investment for it not to happen.

## The difference between centralised management and centralised control

Centralised management of information enables the decision making for every single situation that may happen. This means that the control is exercised on a case-per-case basis. All actions taken have been validated by the centralised system.

Centralised control of information (without centralised management) delegates the decision making to external (not part of the centralised one) parties. In this case, auditing is set up so that the centralised system is able to know the details about the status of the information. Actions are taken without the knowledge of the centralised system; only corrective actions may be taken, and these happen after-the-fact.

In the first case, the creation of guidelines for the decision making is a good practice that helps with the job, but is not mandatory. In the second case, it is mandatory to set a framework for the work of the external parties. Without that framework, there would only be personal (individual) opinions.

## Conclusions about centralised management

Well, I am afraid centralised management is not a silver bullet, but it is extremely useful in many cases. It is important to understand which are the tradeoffs we make, and evaluate the different options at our disposal.

Even when centralised management is not a good option for a company, it is vital to have an identity team. The analysis of the identity team happens in its own section.
