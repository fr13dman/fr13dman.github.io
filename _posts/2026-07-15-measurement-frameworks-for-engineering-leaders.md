---
layout: post
title: "Measurement frameworks for software engineering leaders"
date: 2026-07-15 22:00:00 -0400
categories: [blog, software-engineering, leadership, engineering-effectiveness]
---

Measurement scorecards are all the rage with engineering leadership and management types. But do they really help, or are these metrics and scorecards mostly nothing burgers? I have used some of these metrics in a previous life as an engineering leader, thinking they were good signals for improving how teams operate. But then there is the risk of Goodhart's law, where managers and teams game the game and magically ace the scorecards. I decided to go deeper on some of the more popular frameworks and try to bust the myth. Additionally, I want to broaden my knowledge of how to use these scorecards—especially when it comes to choosing the right ones for the right outcomes.

## Define the terms

| Framework            | Primary Question                                                  | Measures                                                                                                                                                          | Best Used For                                                                                                                                   |
| -------------------- | ----------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| [DORA](https://dora.dev/guides/dora-metrics/) | Can we deliver and recover software changes quickly and reliably? | Deployment frequency, lead time for changes, change failure rate, failed deployment recovery time; later DORA work also emphasizes availability and capabilities. | Delivery performance, operational health, continuous delivery, reliability improvement, executive visibility into software-delivery capability. |
| [SPACE](https://www.microsoft.com/en-us/research/publication/the-space-of-developer-productivity-theres-more-to-it-than-you-think/) | Are developers productive in a balanced and sustainable way? | Satisfaction and well-being, Performance, Activity, Communication and collaboration, Efficiency and flow. | Avoiding simplistic productivity measurement, diagnosing team/system friction, balancing output with well-being and collaboration. |
| [HEART](https://research.google/pubs/measuring-the-user-experience-on-a-large-scale-user-centered-metrics-for-web-applications/) | Are users getting value from the product experience? | Happiness, Engagement, Adoption, Retention, Task Success. | Product-experience measurement, connecting engineering work to customer satisfaction, usability, growth, and retention. |
| [Value Stream Mapping](https://dora.dev/guides/value-stream-management/) | Where does work wait, hand off, or get blocked? | Flow steps, wait time, handoffs, bottlenecks, lead/cycle time, recovery path constraints. | Process visualization, bottleneck removal, aligning improvement work to a concrete outcome. |

## Great set of tools but how do I use 'em

The best executive use is a balanced measurement system: DORA shows delivery capability, SPACE shows the human and system conditions behind that capability, HEART shows whether delivery is creating product value, and VSM shows where the value stream itself is constrained.

Before going into application, it's always helpful to understand these scorecards at greater depth so you know when to apply one versus switch to something else.

### DORA

DORA is a delivery-performance framework for understanding how well a team can change software. The current DORA guide groups metrics into **throughput and instability**: change lead time, deployment frequency, failed deployment recovery time, change fail rate, and deployment rework rate. It emphasizes that these metrics are both lagging indicators of delivery practice and leading indicators for broader organizational performance and well-being.


**Strengths**

- Gives executives a compact, research-backed view of delivery capability.
- Works across stacks because it measures the flow of change through a service, not a specific toolchain.

**Limitations and failure modes**

<div class="note-list" markdown="1">
- DORA is not a measure of individual developer productivity.
- Turning the metrics into targets encourages gaming and discourages teams from surfacing the context behind the numbers.
- Comparing unrelated services or teams can be misleading because their users, risks, and delivery constraints differ.
</div>

### SPACE

SPACE is a multidimensional developer-productivity framework. It exists because productivity cannot be reduced to one metric, one person, or one activity count. Its five dimensions are **S**atisfaction and well-being, **P**erformance, **A**ctivity, **C**ommunication and collaboration, and **E**fficiency and flow.

**Strengths**

- Balances human, team, and system dimensions.
- Makes invisible work, burnout risk, collaboration load, and flow interruptions discussable.

**Limitations and failure modes**

<div class="note-list" markdown="1">
- SPACE can become too broad if leaders ask teams to track every possible metric.
- Survey and sentiment data need privacy, sampling discipline, and cultural context.
- Activity metrics such as commits, PRs, reviews, or story points are weak proxies if isolated.
</div>

### HEART

HEART is a user-experience and product-excellence framework. It measures **H**appiness, **E**ngagement, **A**doption, **R**etention, and **T**ask success.

**Strengths**

- Connects engineering work to user outcomes.
- Helps prioritize which delivery bottlenecks matter because they block user value.
- Prevents delivery excellence from becoming a feature factory.

**Limitations and failure modes**

<div class="note-list" markdown="1">
- Adoption or engagement can be vanity metrics if disconnected from user goals and task success.
- Retention and satisfaction are influenced by pricing, support, market conditions, and brand, not only product quality.
</div>

### VSM

VSM or Value Stream Mapping is a flow-visualization and improvement framework. It maps how work moves from idea to production value, or from incident detection to recovery, and makes wait time, handoffs, queues, rework, and bottlenecks visible.

**Strengths**

- Reveals non-obvious wait states, handoffs, approval queues, batching, environment friction, and recovery-path delays.
- Does not require perfect telemetry to start; low-precision estimates are often enough to expose high-leverage constraints.
- Creates shared understanding across engineering, product, operations, security, compliance, and leadership.

**Limitations and failure modes**

<div class="note-list" markdown="1">
- VSM is facilitation-heavy and depends on having the right people in the room.
- Mapping too much detail can overwhelm teams and hide the few delays that matter most.
- VSM can optimize local process flow while missing developer well-being or product/user value unless paired with SPACE and HEART.
</div>

## How they compare and complement each other

**DORA and SPACE** overlap on flow, delivery systems, and operational health. The difference is emphasis: DORA measures the delivery system's observable performance, while SPACE explains productivity as a sociotechnical system. DORA can reveal that lead time is poor; SPACE helps ask whether the cause is review queues, unclear ownership, excessive interruptions, low morale, weak documentation, or cross-team coordination drag.

**DORA and HEART** connect the engineering system to product outcomes. Shorter lead time lets teams respond to user feedback faster. Lower change fail rate protects happiness and task success. Faster recovery protects trust and retention.

**VSM and DORA** are the strongest operational pair. DORA measures whether delivery and recovery are improving; VSM explains where work is waiting or bouncing between teams. If DORA says lead time is bad, VSM can show whether the dominant delay is code review, test environments, security approval, release batching, or operational handoff. If failed deployment recovery time is bad, VSM can map the recovery path from detection to diagnosis to mitigation to deployment.

**VSM and SPACE** connect flow mechanics to human experience. A map can show five handoffs and three approval queues; SPACE can show the lived cost: interruptions, low focus time, poor collaboration, burnout risk, or frustration with tools. Together they prevent leaders from treating "process improvement" as only a tooling problem.

**VSM and HEART** connect process constraints to customer value. HEART may show weak task success or low retention, but VSM can reveal that the team cannot respond to customer feedback because discovery, design, engineering, compliance, and release steps are too slow or fragmented.

**SPACE and HEART** connect employee experience to customer experience. If teams are burned out, overloaded with invisible coordination work, or unable to maintain flow, user-facing quality eventually suffers. If user outcomes are poor, SPACE helps leaders examine whether teams lack context, tooling, collaboration structures, or sustainable work conditions.

## Real-world selection examples

| Situation | Start with | Measure | Interpret carefully |
| --- | --- | --- | --- |
| A SaaS team releases monthly and misses enterprise commitments. | DORA + VSM | Change lead time, deployment frequency, approval wait time, number of handoffs, escaped defects | If lead time is high, do not ask teams to "go faster" first. Map the value stream to find whether review, test, compliance, release, or environment queues dominate. |
| A mobile app ships frequently but app-store ratings drop after releases. | HEART + DORA | Task success, crash-free sessions, user satisfaction, change fail rate, failed deployment recovery time | Frequent delivery is not success if users experience regressions. Combine user experience signals with stability metrics. |
| A regulated team has many approvals and no one knows which ones matter. | VSM + DORA | Approval wait time, queue age, rework loops, change lead time, change fail rate | VSM separates necessary control points from inherited ritual. Keep controls that reduce risk; redesign queues that add delay without learning. |
| A platform team launches a paved-road deployment system. | SPACE + DORA | Platform adoption, developer satisfaction, cognitive-load survey, time to first deployment, lead time, change failure rate | Adoption alone is weak. Look for reduced friction, better flow, and fewer support escalations. |
| A fintech system has slow incident recovery. | DORA + observability | Failed deployment recovery time, incident detection time, diagnosis time, alert quality, runbook usefulness | Recovery problems may be observability and ownership problems, not just on-call effort. |
| An AI coding rollout shows high token usage. | SPACE + DORA + quality signals | Perceived productivity, flow, review burden, PR cycle time, defect escape rate, rework, cost per accepted change | Token usage can mean exploration, waste, or low-quality output. Treat it as a diagnostic input, not an executive success metric. |
| Executives worry attrition is rising despite strong delivery metrics. | SPACE | Satisfaction, burnout risk, interruptions, collaboration load, perceived ability to do valuable work | DORA can look healthy while teams burn down reserves. SPACE catches sustainability risk before delivery metrics degrade. |
| A new feature has strong delivery velocity but weak adoption. | HEART + DORA | Adoption, activation, retention, task success, lead time to respond to feedback | The team may be building quickly but solving the wrong user problem. HEART supplies product truth; DORA supplies response capacity. |

## Putting it into practice

Start with the decision you need to make, not the metric you already know how to collect. Pick the framework that best matches that decision, establish a small baseline, and use the results to identify one concrete improvement. Add another framework only when it answers a question the first one cannot.

The scorecard is not the outcome. The outcome is a healthier delivery system, a more sustainable engineering environment, and a product that creates value for its users. If a metric stops helping teams learn and act, it is time to change the measurement—not pressure the team to improve the number.
