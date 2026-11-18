# 1. resource_group
resource "azurerm_resource_group" "rg" {
  name = "TestGroup_${var.project_suffix}"
  location = var.location
}