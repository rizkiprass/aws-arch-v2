terraform {
  required_version = ">=0.12"
}
variable "sns-topic-arn" {
  type        = string
  description = "cloudwatch alarm sns topic arn"
}
variable "alarm-threshold" {
  type        = string
  description = "threshold for alarm"
}

variable "instance-id" {
  type        = string
  description = "instance id"
}

variable "cpu" {
  type        = bool
  default     = false
  description = "Create alarm for cpu"
}
variable "memory" {
  type        = bool
  default     = false
  description = "Create alarm for memory"
}
variable "disk" {
  type        = bool
  default     = false
  description = "Create alarm for disk"
}

variable "disk-partition" {
  type        = string
  default     = "C:"
  description = "Selected partition to monitor"
}