terraform {
  required_version = ">=0.12"
}
variable "sns-topic-arn" {
  type = string
  description = "cloudwatch alarm sns topic arn"
}
variable "os" {
  type = string
  description = "Operating System for Alarm"
  default = "Windows"
}
variable "alarm-threshold" {
  type = string
  description = "threshold for alarm"
}

variable "instance-id" {
  type = string
  description = "instance id"
}

variable "memory" {
  type = bool
  default = false
  description = "Create alarm for memory"
}
variable "disk" {
  type = bool
  default = false
  description = "Create alarm for disk"
}

variable "disk-partition" {
  type = string
  default = "/"
  description = "Selected partition to monitor"
}