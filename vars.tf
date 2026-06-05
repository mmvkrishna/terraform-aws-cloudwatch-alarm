variable "log_group_enabled" {
  description = "The variable that decides to create log group, set to false if loggroup creation is not required"
  type        = bool
  default     = true
}

variable "log_group_name" {
  description = "The name of the log group. If omitted, Terraform will assign a random, unique name"
  type        = string
}

variable "retention_in_days" {
  description = "Number of days you want to retain log events in the log group"
  type        = number
  default     = 30
}

variable "kms_key_arn" {
  description = "The ARN of the KMS Key to use when encrypting log data, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted"
  type        = string
  default     = null
}

variable "tags" {
  description = "Please reference the current tagging policy for required tags and allowed values.  See README for link to policy."
  type        = map(string)
}

variable "log_stream_enabled" {
  description = "The variable that decides to create log stream, set to false if log stream creation is not required"
  type        = bool
  default     = false
}

variable "stream_names" {
  default     = []
  type        = list(string)
  description = "Names of streams"
}

variable "existing_log_group_name" {
  description = "Name of the existing Log group to which we are adding New Log streams, If we are creating a log group using this module, you cannot use existing Loggroup"
  type        = string
  default     = null
}
