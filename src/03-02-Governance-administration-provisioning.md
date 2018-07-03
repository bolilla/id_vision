# Uses of an IDM

Identity Managers (IDMs) undertake to do the following things: Identity Governance, administration, provisioning and reconciliation. These operations make sense specially in the management of the identities over which the company has (or should have) tight control: employees, contractors, service accounts, devices, things, etc.

I am referring to IDM as a system that performs (or helps to perform) these actions. It is the same to me whether it is an ad hoc solution, a COTS or a hybrid in between.


## What are these tasks

These are the most typical operations that the common IDM undertakes. Prior to explaining how they should be done, let's talk about what they are (just to avoid misunderstandings later on).

### Identity Governance

According to [Wikipedia](https://en.wikipedia.org/wiki/Governance), "Governance is all of the processes of governing", which may not be extremely useful; it also defines it as "the processes of interaction and decision-making among the actors involved in a collective problem that lead to the creation, reinforcement, or reproduction of social norms and institutions".

Interaction and decision-making seem to be a good explanation of the tasks involved, but in order to decide, one must know and understand, and the limits of knowing and understanding are stated by human brain capacity. What happens when governance is done without knowing and understanding is well depicted by (among others) [The Simpsons](https://www.youtube.com/watch?v=6zQ55S-DJsM).

Since governance requires knowing and understanding, I'll include in this category all the associated tasks, such as reporting, analysis and so on.

Let's have a session of truisms. The government (specially the decision making) is made by the governor, the governor must be a person and hence the decisions are made by people. Automating actions based on business rules does not remove the decision making from the people; the decisions are made ahead of time and actions are taken at a later point. "Delegating" decision making into an algorithm (from [Naïve Bayes](https://en.wikipedia.org/wiki/Naive_Bayes_classifier) to so sophisticated AI) does not either remove the decision making (and the responsibility) from the people.

### Identity administration

This refers to the [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) operations on identities; specially referred to the operations on higher order identities (the ones usually stored in the IDM). The operations on these higher order identities usually originate operations in the identities (generally system accounts) in the IT systems attached to the IDM.

#### ¿Who should perform the administration of the identities in the IDM?

Identity changes originate by decisions of people: a person switches to a different department, comes to the company, leaves the company, requires to use a certain application to perform some beneficial process for the company, etc.

It is the people making the decisions who should "operate" the IDM. It is the people making the decisions who should state those decisions and use the tooling, interfaces, etc in order to do so.

Identity administration should be performed by the people who require the modifications into the identities.

Of course this rises two important questions: ¿How can "business people" without technical knowledge about identities take actions on them? and ¿What do IDM administrators do? The answer is the same: IDM team must provide the tools for the "business people" to use "their language" when making modifications to the identities.

#### Other CRUD operations

Administration of the identities should be performed by the identities consciously making decisions that affect identities, but not all operations on identities can be related to a conscious action.

There are many situations that affect identities without a conscious action (but always with consent): elements of information collected for behaviour analysis (e.g. device used, source IP address), operations on bank accounts that will affect the credit score, re evaluation of information (e.g. recalculation of identity score), etc.

These operations that happen around the identities and are not triggered by a conscious decision, should be automated and the implementation of the automation should be done (or guided by) the identity team.

### Identity provisioning

Identity provisioning is the act of pushing identity information from a central system (usually the IDM) into a provisioned (managed) system.

This requires that the IDM talks the language of the managed system, including understanding the semantics of the system authorisation model and the mapping to the IDM's. This is one of the reasons why the authorisation model of the IDM must include the one of every managed system, and hence be at least as complex as the union of the complexities of all the managed systems.

### Reconciliation

It sounds more civilised than it usually is. This process matches the information in a managed system with the information in the IDM, and takes action on the discrepancies.

The options are these:

- Discrepancies are not detected (e.g. the password has changed, but the IDM does not care about the password field). In this case, the change is ignored.
- Discrepancies are not understood by the IDM (e.g. the differences happen because the user belongs to a new group, but the IDM does not understand the "group" concept of this system). In this case, the change is ignored.
- Discrepancies are detected and the IDM is defined to possess the truth. In this case, the information in the IT system is overwritten with the information in the IDM.
- Discrepancies are detected and the managed system is defined to possess the truth. In this case, the information in the IDM is overwritten with the information in the managed system.
- Discrepancies are detected, but there is no decision taken about which component has the truth. In this case, discrepancies are noted (in the IDM) and no action is taken on the managed system.

Even calling this document a vision, I would not dare to say that in every single situation the IDM will hold the truth and the IT system will not. That would deny the need for operative decisions; these decisions should be the exception, should only be allowed for certain situations (e.g. the address may be changed, but not information about critical privileges), for a brief period of time (because all relevant information managed by the IDM should be consistent between the systems and the IDM) and for good reasons (e.g. the attribute is not properly managed by the IDM).

Of course, one may think it is possible to have a single source of truth and radiate ultimate truth from that point to the rest of the systems. It would be a silver bullet, and I have already said I do not believe in them. I prefer to think on a system flexible enough to deal with reality.

## Workflows

One important part of an IDM solution, and a certainly needed element for the empowering of "business users" into identity administration, is the implementation of tools that support the processes where identity modification happens after the agreement of multiple people: the dreaded "workflows".

Workflow implementations usually contain a mixture of the real business process that wants to be "implemented" ("tooled" could be a better word), some inter-personal relationships that do not belong to the official process but happen nonetheless and useful resources that serve the people involved in the process. It also contains many other things I am not going to get into: steps for information addition, steps for possible delegations (in case one person or group cannot participate for some time), steps for escalation (in case one person or group have unexpectedly not participated in the process for some time), orchestration of technical processes, waits for events to happen, etc. All these components are useful and in many cases necessary, but for the sake of simplicity I'll think about them as a sequence of approvals necessary for an action to be taken on one or many identities.

### The basis for identity administration

As explained before, identity administration should happen as a conscious operation of a person taking a decision, and the means for that decision to be processed may be thought as a workflow. The case of a direct edition of an identity record to update the name of the user may be thought as a single step workflow.

This approach may be overkill for most technical operations, but it comes handy to establishing a common ground for all operations. And remember, this is about a vision; it does not need to be close to reality ;)

One important part of treating all administrative operations in the same way (even those actions performed automatically) is the ability to store the reason for the action for every action. This way, it is possible to understand why does a user have certain privileges, why an account was created, etc.

### The accountability for non-personal identities

We have discussed that there are many identities that do not relate at all with persons, meaning that they are not the avatar of a person. Examples of these kind of identities include devices and things, but there is a case that is mostly overlooked in conventional IAM projects: service accounts; identities that identify systems or services.

Services cannot (should not) be managed in the same way as personal accounts. A service is not going to decide to change its own password, it does not check its own information to ensure it is up do date, it does not have right to be forgotten (even when they are forgotten many times), etc.

In order to make proper management of the service accounts, it is necessary to identify the entity they refer to, create as many identities as needed (e.g. an application may need a service account to access an LDAP service and another account to access a database), associate them to people (preferably more than one person, just in case...), make those people accountable, etc.

The processes involved in the management of these identities are perfect candidates for workflows (even when the people needing these identities are usually very technical people), because that way operations are accounted, traced, approved, etc.

In many cases there should be no person knowing the secrets (e.g. password or private key) of a system identity, and this can "easily" be achieved by wrapping administrative operations with workflows.

### User privilege cloning

When someone (let's call him Jake) joins the team and is going to do "more or less" the same job someone else (let's say John) is already doing, there is a very typical request: "Give Jake the same privileges as John". This may happen for just one system or for all of the systems of the company.

This has been demonised over the years as a bad practice because it is necessary to understand that the privileges being granted are bering grated for a reason. When cloning the privileges of a user into another one, there is no acknowledgement that these (and not less) are the minimum required privileges for the newcomer.

In order to circumvent this, I have heard managers asking for an exhaustive list of the privileges of John just to be able to make a proper request with all the privileges that Jake should have. In this case, the reason for the privileges of Jake will be listed as "requested by the manager", instead of stating that it is a "user cloning requested by the manager".

The only option I can envision to prevent this is by allowing user cloning. This enables labelling these privileges as "cloned from John", and that labelling enables (even when does not guarantee) a proper management when John changes his privilege set.

I prefer to adjust my model to reality instead of trying to make reality adjust to my model; mainly because reality is much smarter than me.

## Complexity of the authorisation model

In order to provision and reconcile a system, it is necessary to understand that system. In the context of an IDM, this is generally related to authentication and authorisation, so it is also related to the authorisation model of the system.

When you have to manage (i.e. understand) many IT systems, it is necessary to understand them, including their authorisation models. This makes it necessary to include all the authorisation models of the managed system as part of the IDM's model.

In the context of identity management, mistakes are paid in exponential complexity. It is [more or less] obvious that it is much more complex to manage user-resource permissions instead of user-group and group-resource permissions. If an IDM could only manage user-resource permissions, and a managed system would enable groups, the IDM connector (the piece in charge of the provisioning and the reconciliation) would have a really difficult time mapping information to and fro the IDM, the IDM administrators would have a hard time understanding the implications of the actions, etc.

If the IDM is not [trivially] capable of managing the authorisation model of a managed system, it is going to cost dearly to properly manage (specially understand) that system.

## Where entitlements belong

Entitlements (the privileges that enable operations on resources) are obviously related to the managed systems. An entitlement in a system does not mean much (¿anything?) in another system.

Entitlements for a particular system may be stored inside the IDM or in a different repository, and when authorisation takes place, that information may be retrieved from the IDM or from that other different repository. Let's analyse the options.

### There is no IDM; only the system repository

If there is no IDM, there is no provisioning or reconciliation; there is no centralised knowledge about the identities in this system. We can call it an outlaw, but it is a common situation in many systems (e.g. administrative accounts of the laptops of contractors).

Anyway, if there is no IDM, it is not a discussion for this section.

### IDM as sole repository for authorisation

In this case, it is the IDM the only one that stores entitlement information. There is no "different repository".

IDMs are very well suited for storing and managing authorisation information, and are a great place to store some other information that may come handy.

That other information is a downward slope. Storing first and last name of the identity may be a good thing: it helps understanding the identity and it also can be useful to be propagated to some external repositories (or consumed by external systems), but the line between storing all the information in the world and storing just the useful information is a matter on how down the slope to chaos you want to go. The more information you store, the more difficult it is to change, evolve and please everyone relying on the system.

Regarding authorisation information, it is very important to understand that using the IDM as the sole source for authorisation for a system makes the IDM itself part of that system at execution time: if the system needs to be backed up, the IDM needs to be backed up at the same time (or at least maintaining coherence with the rest of the information of the system), if the system needs lightning fast authorisation, the IDM must be lightning fast ... for this system (while servicing other systems), if the system needs to run in different countries, with different policies, the IDM must follow through, etc.

This scenario remains in my vision because there are many applications that would benefit from this approach, and many of them will also benefit from externalised authorisation.

### IDM plus another repository

So we have decided to duplicate information, this is not the option for the faint-hearted, as there are some things to consider...

#### Entitlement Synchronisation

We have information in two places; we better make sure it is the same. This calls for synchronisation (at the entitlement level; not just at the account/account level), which may happen periodically, on demand or can be triggered by changes in each of the ends.

Of course this is not easy, but as this is mandatory for the rest of the discussion, let's think it is a properly solved problem and the information is synchronised.

#### Information to share

We can decide to share all the information or just some of it. If we choose to keep secrets from the IDM, we better have some good reasons for it.

The IDM can only manage the information it knows about (another truism). If we choose to hide "low level" entitlements and decide to share just "relevant" entitlements, chances are at some point we will forget to share a "relevant" entitlement. In addition to that, it is important to understand that governance processes (and audit, etc) will only be as effective as the information shared allows.

On the other hand, we may decide to store all the entitlements in the IDM. In this case, we better have a proper authorisation model in place in the IDM, but also in the managed system.

#### Bringing the complexity into the IDM

Remember that adding information from different sources adds on to the complexity of the IDM.

If the managed system manages user permissions for a branch office, and we define 100 different possible roles in an office and we have 1000 offices, we have two options: either the system enables the definition of entitlements based on the actual office and the actual role, or we create all possible roles for all possible offices. In the first case we would be needing around 1100 elements, in the second case, we would be needing 100000; the difference between addition and multiplication.

Please note we may have the best, most complete, most complex authorisation model in the IDM, and even in that case, if the model of the managed system makes us create 100k roles, and we choose to share that information with the IDM, we will have 100k roles in the IDM for one single system.

Once we have added all the information from the managed systems, we may want to have additional roles, compositions of these roles with other roles, etc.

Remember: in identity management mistakes are paid in exponential complexity.

## Identity management as an agility enabler

Identity management is one of those disciplines regarded as business stoppers for a long time, just like some kind of tax with no visible ROI. This same thing has happened with security for a long time.

In the case of security [Sony](https://en.wikipedia.org/wiki/Sony_Pictures_hack), [Ashley Madison](https://en.wikipedia.org/wiki/Ashley_Madison#Data_breach), [JP Morgan](https://en.wikipedia.org/wiki/2014_JPMorgan_Chase_data_breach) and [many more companies](http://www.informationisbeautiful.net/visualizations/worlds-biggest-data-breaches-hacks/) have shown that security is necessary, and something that should be sought after better sooner rather than later. So far (fortunately) there are not many companies that have shown the world what a wrong approach to identity management implies. This is because a bad identity management strategy is a silent killer.

We have discussed many times that mistakes in IAM are paid in exponential complexity. This means that the administration of the overall system is never impossible. It simply takes more and more resources, but it is very difficult to draw a line on the sand and say "enough".

A good identity strategy enables the agile principles; empowers [knowledge workers](https://en.wikipedia.org/wiki/Knowledge_worker) and accelerates innovation.

The consequences of a bad (or at least not good enough) identity strategy has two ["smells"](https://en.wikipedia.org/wiki/Code_smell):

- It is very difficult to make something work; specially in the beginning or when relevant changes come into place. There are many reasons for this; for example: identity management processes focused on auditing instead of enabling, manual steps (and authorisations), and many other situations that have to be tackled manually because they could not be thought in advance.
- It blew up at some point and you get to know it too late. This moment usually comes at the realisation that the company has twice as many roles as it has users, that the number of business rules is incommensurable, that the discrepancies found during a reconciliation could be less if you had tried to reconcile a system of a different company, etc.

It is extremely difficult to design a good identity strategy (I hope this document can shed some light on what to take into account), but its consequences are great. Imagine a world like this:

- When a newcomer has all the privileges he/she needs the day he/she comes into the company (including desk, laptop, mobile and a welcome pack with a t-shirt of the company, some sweets and a handwritten letter of welcome. I acknowledge I have received such a welcome pack.
- When a person changes department, privileges change accordingly.
- When a person leaves the company, all privileges are revoked.
- Most of the time, things simply work and people can do whatever they need to do.
- When someone needing a privilege knows what to do: how to know what is needed, how to request it, the process that the request is going to follow (if any), who is responsible for each step, the implications of the request (e.g. whether it is risky for the company), etc.
- When someone needs to be involved in an identity management process (e.g. approval of some privileges change, or a recertification), that person knows his participation is needed, why it is relevant, why it has to be done by him/her, what to do, how to do it, etc.
- Compliance is guaranteed and easy to prove.
- Policies are automatically enforced, violations are addressed according to its relevance: critical transgressions are not permitted; trivial matters are notified and tracked.

If there is a word for identity strategy definition it would be "preventive". In order to become a true enabler, identity management must focus on anticipating the needs of the company, specially because solving existing problems tends to create "patches", and these patches will possibly not destroy the system; they will (I'm sure at this point you already know how this sentence ends) create exponential complexity.
