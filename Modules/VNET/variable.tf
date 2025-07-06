variable "vnet_name" {
    type = string
    description = "vnet name"
}

variable "address_space" {
    type = list(string)   
    description = "ad_space"
}
variable "location" {
  type = string
  description = "location"
}

variable "resource_group_name" {
  type = string
  description = "value"
}