resource "azurerm_container_group" "azuredemocontainergroup" {
  name                = "azuredemocontainergroup"
  location            = var.location
  resource_group_name = azurerm_resource_group.azuredemocontainerrg.name
  ip_address_type     = "public"
  dns_name_label      = "AzureDemodns"
  os_type             = "Linux"

  container {
    name   = "sqldatabase"
    image  = "mcr.microsoft.com/mssql/server"
    cpu    = "2"
    memory = "1"
    environment_variables = {
            "ACCEPT_EULA": "Y"
            "SA_PASSWORD": "Test@1234"
    }
    ports {
      port     = 1433
      protocol = "TCP"
    }   
  }

 container {
    name   = "redis"
    image  = "redis"
    cpu    = "2"
    memory = "1"   
  }

  container {
    name   = "customerapi"
    image  = "theksha/customerapi:v2"
    cpu    = "2"
    memory = "1"
    environment_variables = {
            "DBSERVER": "sqldatabase"
            "DBUSER": "sa"
            "DBPASSWORD": "Test@1234"
    } 
    ports {
      port     = 80
      protocol = "TCP"
    }   
  }

  container {
    name   = "nginx"
    image  = "theksha/customnginx:v2"
    cpu    = "2"
    memory = "1"
    
    ports {
      port     = 4000
      protocol = "TCP"
    }
   }
  }