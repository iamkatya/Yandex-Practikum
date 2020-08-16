SELECT
EXTRACT(week from flights.arrival_time:: date) as week_number,
COUNT(ticket_flights.ticket_no) AS ticket_amount,
FEST.festival_week AS festival_week,
FEST.festival_name AS festival_name
FROM
ticket_flights 
LEFT JOIN flights ON flights.flight_id=ticket_flights.flight_id
LEFT JOIN airports ON airports.airport_code=flights.arrival_airport
LEFT JOIN 
(SELECT
festival_name AS festival_name,
EXTRACT(week from festival_date) as festival_week
FROM
festivals
WHERE
festival_date BETWEEN '2018-07-23' AND '2018-09-30' 
AND festival_city = 'Москва') AS FEST ON FEST.festival_week=EXTRACT(week from flights.arrival_time:: date)
WHERE
flights.arrival_time:: date BETWEEN '2018-07-23' AND '2018-09-30'
AND airports.city = 'Москва'
GROUP BY
week_number,
festival_week,
festival_name