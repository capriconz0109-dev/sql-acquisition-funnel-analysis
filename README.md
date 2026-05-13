# Acquisition Quality Audit: When Traffic Volume Hides Conversion Quality

A marketing performance analysis using GA4 sample ecommerce data and BigQuery SQL to test whether the highest-volume traffic source was also the highest-quality source.

## Business Question

Does the channel that brings the most traffic also bring the best conversion quality?

Google organic appeared strongest at first glance because it drove the highest session and product-view volume.

This project tests whether that volume leadership still holds when performance is measured through funnel progression from product view to purchase.

## Key Finding

The highest-volume acquisition source was not the highest-quality source in this sample.

Google organic led on reach and product-view volume, but direct and referral traffic showed stronger purchase efficiency.

This matters because marketing performance should not be judged by traffic volume alone. A source can bring more visitors while contributing weaker downstream conversion progression.

## Why This Matters for Marketing

For marketing teams, reach is only the first layer.

A campaign or acquisition source may look strong at the top of the funnel, but the real question is whether users continue moving toward meaningful actions.

This project shows why marketing analysis should compare:

- traffic volume
- product interest
- add-to-cart behaviour
- checkout progression
- purchase efficiency

The main lesson:

**Traffic volume captures scale. Funnel progression reveals quality.**

## Dataset and Tools

This project uses Google’s GA4 sample ecommerce dataset in BigQuery.

Tools used:

- BigQuery
- SQL
- GA4 sample ecommerce export

## Analytical Design

The analysis was built at session level, not raw event level.

Sessions were defined by combining:

- `ga_session_id`
- `user_pseudo_id`

This created a consistent session identifier for tracking progression within a visit.

Funnel progression was measured across:

1. `view_item`
2. `add_to_cart`
3. `begin_checkout`
4. `purchase`

The source comparison included:

- Google organic
- direct
- referral
- Google CPC

`device_category` was included as supporting context to check whether the pattern was mainly driven by source rather than device mix.

## Query Workflow

The SQL workflow is organised in `queries/`:

1. `01_funnel_validation.sql`  
   Validates event-stage coverage and confirms the funnel stage structure.

2. `02_session_funnel_counts.sql`  
   Builds session-level funnel counts across `view_item` to `purchase`.

3. `03_source_level_comparison.sql`  
   Compares source-level progression to identify differences in conversion efficiency.

4. `04_device_supporting_analysis.sql`  
   Adds device-level context to support source-level interpretation.

## Key Findings

- Google organic drove the highest session volume and product-view volume.
- Direct traffic converted more efficiently than organic search despite lower volume.
- Referral traffic from `shop.googlemerchandisestore.com` produced the strongest overall view-to-purchase rate in the sample.
- Google CPC contributed meaningful traffic but converted less efficiently than direct and referral.
- Device differences added context, but the main pattern was driven more by acquisition source than by device.

## Business Interpretation

The key result is that scale and conversion quality did not move together.

Organic search looked strongest at the top of the funnel, but direct and referral showed stronger downstream progression toward purchase.

This reframes the acquisition question from:

**Which channel brings the most visitors?**

to:

**Which channel brings users who continue moving through the funnel?**

For marketing work, this matters because budget, content, and campaign decisions should not be based only on reach. A high-volume source may still need optimisation if downstream progression is weaker.

## Takeaway

The highest-volume acquisition channel was not the highest-value channel in this sample.

Traffic volume captured scale. Session-level funnel progression revealed quality.

## Repository Guide

- `queries/` — SQL scripts for funnel validation, session-level construction, source comparison, and device supporting analysis
- `assets/` — visual outputs and screenshots used in the case study
- `README.md` — project overview, business question, analytical design, and evidence map

## Scope and Limitations

This is a self-directed comparative sample analysis using GA4 sample ecommerce data.

Important boundaries:

- The project uses Google’s public GA4 sample ecommerce dataset, not live commercial data.
- Results are descriptive of observed progression patterns in this dataset.
- The project does not claim causal channel effects or universal acquisition rankings.
- Findings should be read as a marketing performance analysis method, not as a final commercial media recommendation.

## Contribution and AI Disclosure

This was a self-directed individual project.

I handled the concept, SQL workflow, session-level analysis design, source comparison logic, business interpretation, writing direction, and final review.

AI tools were used to support brainstorming, drafting, rewriting, SQL debugging, and workflow structuring. Final direction, judgment, interpretation, and quality control were done by me.
