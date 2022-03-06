-- write your code in SQLite 3.11.0

select event_type, value_difference from
    ( --This is for seeing the last meaningfull table together
    select 
    event_type
    ,value
    ,max(time) as second_time
    ,first_value
    ,first_time
    ,(first_value - value) as value_difference
    from
            (--This  table is a joint table of events table and event_type's max time and max time's value. 
            select 
              e.value as value
            , e.time as time
            , ft.event_type as event_type
            , ft.first_value as first_value
            , ft.first_time as first_time 
            from events e 
            join (--This join adds max time and max time's value at the right side of events table.
                SELECT 
                  event_type, value as first_value
                , max(time) as first_time 
                from 
                  events 
                group by event_type 
                 ) ft
            on ft.event_type = e.event_type 
            )
    where time < first_time --This chooses second time.
    group by event_type
    ) 
order by event_type asc
;

