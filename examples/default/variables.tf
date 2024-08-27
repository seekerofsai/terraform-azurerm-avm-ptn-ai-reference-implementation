variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see <https://aka.ms/avm/telemetryinfo>.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

variable "jumpbox" {
  type = object({
    size                           = string,
    zone                           = number,
    accelerated_networking_enabled = bool
  })
  default = {
    size                           = "Standard_D4s_v3"
    zone                           = 1
    accelerated_networking_enabled = true
  }
  description = "This variable configures the jumpbox for this example"
}

variable "location" {
  type        = string
  default     = "uksouth"
  description = "The location for the resources."
}
