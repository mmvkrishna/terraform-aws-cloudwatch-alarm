output "log_group_arn" {
  value       = aws_cloudwatch_log_group.loggroup.*.arn
  description = "ARN of the log group"
}

output "stream_arns" {
  value       = aws_cloudwatch_log_stream.logstream.*.arn
  description = "ARNs of the log streams"
}

output "log_group_name" {
  description = "Name of log group"
  value       = aws_cloudwatch_log_group.loggroup.*.name
}
