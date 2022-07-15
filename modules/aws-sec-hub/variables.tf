variable "cis" {
  type = bool
  description = "Enable CIS AWS Foundations Benchmark v1.2.0"
  default = false
}

variable "pci" {
  type = bool
  description = "Enable AWS Foundational Security Best Practices v1.0.0"
  default = false
}