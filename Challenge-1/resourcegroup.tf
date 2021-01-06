# Create a resource group
resource "azurerm_resource_group" "azuredemocontainerrg" {
  name     = "azuredemocontainerrg"
  location = var.location
}