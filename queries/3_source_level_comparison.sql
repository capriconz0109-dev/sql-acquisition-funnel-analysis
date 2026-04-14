WITH funnel_events AS (
  SELECT
    CONCAT(
      user_pseudo_id,
      '-',
      CAST((
        SELECT value.int_value
        FROM UNNEST(event_params)
        WHERE key = 'ga_session_id'
      ) AS STRING)
    ) AS session_id,
    traffic_source.source AS traffic_source,
    traffic_source.medium AS traffic_medium,
    event_name
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
),

session_funnel AS (
  SELECT
    session_id,
    traffic_source,
    traffic_medium,
    MAX(CASE WHEN event_name = 'view_item' THEN 1 ELSE 0 END) AS viewed_item,
    MAX(CASE WHEN event_name = 'add_to_cart' THEN 1 ELSE 0 END) AS added_to_cart,
    MAX(CASE WHEN event_name = 'begin_checkout' THEN 1 ELSE 0 END) AS began_checkout,
    MAX(CASE WHEN event_name = 'purchase' THEN 1 ELSE 0 END) AS purchased
  FROM funnel_events
  WHERE session_id IS NOT NULL
  GROUP BY 1, 2, 3
),

aggregated AS (
  SELECT
    traffic_source,
    traffic_medium,
    COUNT(*) AS sessions,
    SUM(viewed_item) AS view_item_sessions,
    SUM(added_to_cart) AS add_to_cart_sessions,
    SUM(began_checkout) AS begin_checkout_sessions,
    SUM(purchased) AS purchase_sessions
  FROM session_funnel
  WHERE traffic_source IN ('google', '(direct)', 'shop.googlemerchandisestore.com')
    AND traffic_medium IN ('organic', '(none)', 'cpc', 'referral')
  GROUP BY 1, 2
)

SELECT
  traffic_source,
  traffic_medium,
  sessions,
  view_item_sessions,
  add_to_cart_sessions,
  begin_checkout_sessions,
  purchase_sessions,
  ROUND(100 * SAFE_DIVIDE(add_to_cart_sessions, view_item_sessions), 2) AS view_to_cart_rate,
  ROUND(100 * SAFE_DIVIDE(begin_checkout_sessions, add_to_cart_sessions), 2) AS cart_to_checkout_rate,
  ROUND(100 * SAFE_DIVIDE(purchase_sessions, begin_checkout_sessions), 2) AS checkout_to_purchase_rate,
  ROUND(100 * SAFE_DIVIDE(purchase_sessions, view_item_sessions), 2) AS overall_view_to_purchase_rate
FROM aggregated
WHERE view_item_sessions >= 500
ORDER BY sessions DESC;
