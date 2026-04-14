SELECT
  event_name,
  COUNT(*) AS event_count,
  COUNT(DISTINCT CONCAT(user_pseudo_id, '-', CAST((
    SELECT value.int_value
    FROM UNNEST(event_params)
    WHERE key = 'ga_session_id'
  ) AS STRING))) AS session_count
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name IN ('view_item', 'add_to_cart', 'begin_checkout', 'purchase')
GROUP BY event_name
ORDER BY
  CASE event_name
    WHEN 'view_item' THEN 1
    WHEN 'add_to_cart' THEN 2
    WHEN 'begin_checkout' THEN 3
    WHEN 'purchase' THEN 4
  END;
