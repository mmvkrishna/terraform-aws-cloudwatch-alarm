resource "aws_cloudwatch_log_group" "loggroup" {
  count             = var.log_group_enabled ? 1 : 0
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  tags              = merge({ "Name" = var.log_group_name }, var.tags)
  kms_key_id        = var.kms_key_arn == "" ? "" : var.kms_key_arn
}

resource "aws_cloudwatch_log_stream" "logstream" {
  count          = var.log_stream_enabled && length(var.stream_names) > 0 ? length(var.stream_names) : 0
  name           = element(var.stream_names, count.index)
  log_group_name = var.log_group_enabled ? aws_cloudwatch_log_group.loggroup.*.name : var.existing_log_group_name
}
