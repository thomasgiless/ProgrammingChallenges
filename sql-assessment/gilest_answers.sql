#question 1 

SELECT 
	date,
	SUM(impressions) AS total_impressions
FROM 
	marketing_performance mp 
GROUP BY 
	date 
ORDER BY 
	date;


#question 2

SELECT
	state,
	SUM(revenue) AS total_revenue
FROM 
	website_revenue wr 
Group BY 
	state  
Order BY 
	total_revenue DESC 
LIMIT 3;

#question 3

SELECT
    ci.name,
    SUM(mp.cost) AS total_cost,
    SUM(mp.impressions) AS total_impressions,
    SUM(mp.clicks) AS total_clicks,
    SUM(wr.revenue) AS total_revenue
FROM
    campaign_info ci
INNER JOIN
    marketing_performance mp ON ci.id = mp.campaign_id
INNER JOIN
    website_revenue wr ON ci.id = wr.campaign_id
GROUP BY
    ci.name;

#question 4 the state of Georgia generated the most conversions. 

SELECT
    mp.geo,
    SUM(mp.conversions) AS total_conversions
FROM
    campaign_info ci
INNER JOIN
    marketing_performance mp ON ci.id = mp.campaign_id
WHERE
    ci.name = 'Campaign5'
GROUP BY
    mp.geo;


#question 5, I think it is safe to say that campaign 3 was the most efficient
CREATE TABLE campaign_totals as
SELECT
    ci.name,
    SUM(mp.cost) AS total_cost,
    SUM(mp.impressions) AS total_impressions,
    SUM(mp.clicks) AS total_clicks,
    SUM(wr.revenue) AS total_revenue
FROM
    campaign_info ci
INNER JOIN
    marketing_performance mp ON ci.id = mp.campaign_id
INNER JOIN
    website_revenue wr ON ci.id = wr.campaign_id
GROUP BY
    ci.name;

SELECT 
	name, 
	total_clicks / CAST((total_clicks + total_impressions)AS FLOAT) AS click_conversion,
	(total_revenue - total_cost) / total_cost AS ROI
FROM 
	campaign_totals;


#question 6
