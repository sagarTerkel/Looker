view: scorecard_metrics {
  derived_table: {
    sql: SELECT
        response_date + INTERVAL (DATEDIFF(response_date, curdate()) DIV 7) WEEK AS week_start_date, count(answer) as answer_count
      FROM
          terkelbeta.answers
      WHERE
          answer IS NOT NULL and skipped = 0
          group by DATEDIFF(curdate(),response_date) DIV 7;
          -- Query for New answers in the past week
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: week_start_date {
    type: date
    sql: ${TABLE}.week_start_date ;;
  }

  dimension: answer_count {
    type: number
    sql: ${TABLE}.answer_count ;;
  }

  set: detail {
    fields: [week_start_date, answer_count]
  }
}
