# SQL Acquisition Funnel Analysis

A session-level SQL funnel analysis of acquisition quality using GA4 ecommerce event data in BigQuery. This project compares whether organic, direct, referral, and paid traffic drove scale, purchase intent, or both.

## Business problem

High traffic volume does not automatically mean high commercial value. The goal of this project was to assess whether the largest acquisition sources also generated the strongest downstream purchase efficiency.

## Dataset

Google’s GA4 sample ecommerce dataset in BigQuery, using event-level ecommerce actions including `view_item`, `add_to_cart`, `begin_checkout`, and `purchase`, along with traffic source, medium, and device fields.

## Analytical approach

- Validated that the funnel stages were present and usable in the dataset
- Built the analysis at the session level by combining `ga_session_id` with `user_pseudo_id`
- Mapped progression across four stages: `view_item`, `add_to_cart`, `begin_checkout`, and `purchase`
- Compared stage progression and overall view-to-purchase rates across organic, direct, referral, and paid traffic
- Used device as a supporting layer to test whether the source-level pattern held across desktop and mobile

## Key findings

- Google organic drove the highest session and product-view volume
- Direct traffic converted more efficiently than organic search despite lower volume
- Referral traffic from `shop.googlemerchandisestore.com` produced the strongest overall view-to-purchase rate
- Google CPC contributed meaningful traffic but converted less efficiently than direct and referral traffic
- Device differences added context, but the main performance pattern was driven more by source than by device

## Why it matters

The highest-volume channel was not the highest-value one. This project shows why acquisition performance should be evaluated using both traffic scale and downstream conversion quality, not traffic alone.

## Files in this repo

- `queries/01_funnel_validation.sql` — validates that the ecommerce funnel stages exist in the dataset
- `queries/02_session_funnel_counts.sql` — builds session-level counts across funnel stages
- `queries/03_source_level_comparison.sql` — compares traffic sources on volume and conversion quality
- `queries/04_device_supporting_analysis.sql` — uses device as a supporting segmentation layer
- `assets/` — stores screenshots used in the case study
