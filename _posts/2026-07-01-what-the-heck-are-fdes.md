---
layout: post
title: "What the heck is forward deployed engineering"
date: 2026-07-01 22:00:00 -0400
categories: [blog, software-engineering, forward-deployed-engineering, ai]
---

Since leaving big tech early this year, I spent a good amount of time getting my life back, getting healthy, reading and trying to get excited about technology. As most people with a ton of time on their hands I started reading about AI, LLMs and then I stumble upon this new fangled term (which btw isnt new at all see the history lesson below) - **forward deployed engineering** and I am intrigued. So decided to do some research and write something to help me and hopefully help others understand these new concepts.

## Define the terms

Forward Deployed Engineering (FDE) is an operating model where engineers embed close to customer environments and own adoption outcomes, not just code delivery.

## Some History

Did some digging - and it seems this is a concept that Palantir evangalized. **Why Palantir?** Because their early customers were messy, high-stakes organizations: defense, intelligence, law enforcement, later healthcare, aviation, energy, finance, etc. These customers did not just need software installed but someone to sit inside the operational mess.

So Palantir sent engineers into the field. Actual builders who would integrate data, build workflows, debug deployments, understand users, and bring that learning back into the platform.

### Why It Got Hot Again Around 2023-2026

AI made FDE newly relevant. With traditional SaaS and Software Engineering, the product surface is relatively stable where-in customers configure, integrate, and train users. With AI systems, especially LLM-based products, the “product” is often deeply entangled with the customer’s actual workflow.

## Comparing the SDLC process

![Software Development Life Cycles]({{ "/assets/images/2026/07/sdlc-software-fde-engineering.png" | relative_url }})

## Getting to the point - are FDEs just customer integrators then?

Forward deployed engineering sits in an awkward and powerful place: close enough to customers to see what the product actually needs, and technical enough to change the system when the gap is real. That is what makes the role useful but also what makes it dangerous.

The easy misunderstanding is that FDEs are just customer integrators. They connect systems, map data, configure workflows, and get customers live. That is part of the job, but it is not the whole job. The stronger version of the model is that FDEs turn field reality into product leverage. Sometimes that means integrating around the product.

FDE work usually falls into three layers.

| Layer | What changes | Typical examples | Primary risk |
| --- | --- | --- | --- |
| Integration changes | Customer-specific configuration or glue | Data mappings, one-off import scripts, workflow setup, auth configuration | Bespoke maintenance burden |
| Product changes | Reusable user-facing capability | New workflow template, admin setting, reporting view, API option, onboarding flow | Roadmap sprawl |
| Service changes | Underlying backend, infrastructure, data model, reliability, security, or API behavior | New permission model, ingestion pipeline change, scaling fix, tenant isolation improvement, public API contract change | Production, security, and ownership risk |

## Turning what FDEs do from potential risks to super powers - but with caution

Product changes are the natural output of healthy FDE work. The FDE sees repeated friction in the field and converts it into something the product should support directly. An FDE team should satisfy the current customer while asking, "What would make the next deployment faster, cleaner, or unnecessary?"

Good product changes from FDEs have a few properties:

<div class="note-list" markdown="1">

- They reduce future deployment effort.
- They are understandable to core product and engineering teams.
- They preserve the product's conceptual integrity.
- They come with evidence from real customer usage.
- They are absorbed into normal roadmap, support, documentation, and ownership systems.

</div>

The pitfall is roadmap distortion. A field team is exposed to urgent, loud, high-value customers. That can make every customer request feel strategically important. ***Product leadership still has to decide whether a field-discovered need is part of the product's durable direction or just a paid exception.***

Service Changes on the other hand is a different beast. They happen when the customer-facing requirement cannot be solved responsibly at the product surface.

Examples of Service changes that FDEs may need to work on:

<div class="note-list" markdown="1">

- A customer needs row-level access control, but the current authorization model only supports coarse tenant-level permissions.
- A deployment needs low-latency ingestion, but the existing pipeline batches too slowly.
- A regulated customer needs stronger auditability, but the service does not emit the right events.
- A large account exposes scaling limits in a backend job, queue, database, or API gateway.

</div>

In these cases, the FDE is not merely "adding a product feature." They are touching service behavior that may affect reliability, security, data correctness, cost, public contracts, and other customers.

A useful rule to consider:

<div class="note-list note-list--rule" markdown="1">

- If the change is specific to one customer's environment, FDE can usually own it.
- If the change is repeated across customers, FDE should productize it.
- If the change affects service reliability, security, permissions, billing, data model, public APIs, or shared infrastructure, the owning engineering team must be involved.

</div>

The FDE can still drive the work. They can write the first design, produce the customer evidence, prototype the behavior, contribute code, and pressure-test the rollout. ***But the service owner needs to sign up for long-term correctness and operations.***

Finally, measurement as a signal of success is important in this ever-changing landscape. If FDEs are measured only on customer satisfaction, revenue unblocked, or launches completed, they will naturally create custom solutions. If they are measured only on clean productization, they may move too slowly for the field.

A better scorecard balances three kinds of success:

| Metric category | Healthy signals |
| --- | --- |
| Customer outcome | Time to value, production usage, renewal or expansion influence, workflow adoption |
| Product leverage | Reusable features shipped, deployment effort reduced, repeated patterns productized, roadmap decisions influenced |
| Operational health | Number of bespoke paths, post-launch incident rate, support burden, service owner acceptance, security review completion |

The strongest FDE teams can show that each customer deployment makes the next deployment easier.

## A Practical Decision Framework

When an FDE discovers a customer need, classify it before building too much.

| Question | If     yes | Likely path |
| --- | --- | --- |
| Is this unique to one customer's environment? | Yes | Integration or adapter owned by FDE, with explicit maintenance window |
| Have multiple customers needed the same thing? | Yes | Product change or reusable template |
| Does it require new backend behavior? | Yes | Joint FDE plus service-owner design |
| Does it affect auth, data model, billing, reliability, security, or public APIs? | Yes | Service change with normal production governance |
| Would future customers expect this as part of the product? | Yes | Productize and document |
| Would we be embarrassed to explain this special case to the next engineering leader? | Yes | Stop and redesign |
