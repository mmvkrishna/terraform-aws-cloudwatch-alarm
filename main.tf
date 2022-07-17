resource "aws_cloudwatch_metric_alarm" "this" {

  alarm_name                            = var.alarm_name
  alarm_description                     = var.alarm_description
  actions_enabled                       = var.actions_enabled
  alarm_actions                         = var.alarm_actions
  ok_actions                            = var.ok_actions
  insufficient_data_actions             = var.insufficient_data_actions
  comparison_operator                   = var.comparison_operator
  evaluation_periods                    = var.evaluation_periods
  threshold                             = var.threshold
  unit                                  = var.unit
  datapoints_to_alarm                   = var.datapoints_to_alarm
  treat_missing_data                    = var.treat_missing_data
  evaluate_low_sample_count_percentiles = var.evaluate_low_sample_count_percentiles

  # Below 6 Arguments conflicts with metric_query
  metric_name        = var.metric_query == [] ? var.metric_name : null
  namespace          = var.metric_query == [] ? var.namespace : null
  period             = var.metric_query == [] ? var.period : null
  statistic          = var.metric_query == [] ? var.statistic : null
  extended_statistic = var.metric_query == [] ? var.extended_statistic : null
  dimensions         = var.metric_query == [] ? var.dimensions : null

  # conflicts with metric_name
  dynamic "metric_query" {
    for_each = var.metric_query
    content {
      id          = lookup(metric_query.value, "id")
      label       = lookup(metric_query.value, "label", null)
      return_data = lookup(metric_query.value, "return_data", null)
      expression  = lookup(metric_query.value, "expression", null)

      dynamic "metric" {
        for_each = lookup(metric_query.value, "metric", [])
        content {
          metric_name = lookup(metric.value, "metric_name")
          namespace   = lookup(metric.value, "namespace")
          period      = lookup(metric.value, "period")
          stat        = lookup(metric.value, "stat")
          unit        = lookup(metric.value, "unit", null)
          dimensions  = lookup(metric.value, "dimensions", null)
        }
      }
    }
  }

  tags = merge(var.tags, { "Name" = "var.alarm_name" })
}
