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
    size                           = "Standard_D4as_v4"
    zone                           = 3
    accelerated_networking_enabled = true
  }
  description = "This variable configures the jumpbox for this example"
}
