—question1 
SELECT 
	date,
	SUM(impressions) AS total_impressions
FROM 
	marketing_performance mp 
GROUP BY 
	date 
ORDER BY 
	date;


—question 2
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
— Ohio, the third best state, generated $37,577


—question 3
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

—question 4 

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
—The state of Georgia generated the most conversions for campaign 5.


—question 5
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
/*My first thought when I saw the term ‘efficiency’ was ROI. ROI allows us to see how much return we receive for every dollar invested. When looking at this metric we can see that Campaign 4 was most efficient when looking at the investment aspect of the campaigns with and ROI of 40.16. 
Another metric that we can consider, when looking at campaign efficiency is ‘click conversion’ which I defined to be as the ratio of clicks to clicks and impressions. Campaign 5 was the most efficient when looking that this metric with 0.57. 
It is important to note that Campaign 4, which had the highest ROI($40.16), also had the lowest click conversion (0.41). Conversely Campaign 5, which had the highest click conversion (0.57), had the lowest ROI ($32.45)
This relationship may indicate the possibility of an inverse linear relationship between ROI and click conversion./*
