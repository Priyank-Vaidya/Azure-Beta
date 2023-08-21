terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.96.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "a71d4f50-ed78-4d3f-bc57-b8c416bdd4fe"
  client_id = "5b34d308-a9b0-4852-8aaf-feb2ccf7e36c"
  tenant_id = "84c31ca0-ac3b-4eae-ad11-519d80233e6f"
  features {} 
}

resource "azurerm_resource_group" "app_alpha_node"{
  name=local.resource_group
  location=local.location
}

resource "azurerm_storage_account" "functionstore_0898891" {
  name                     = "functionstore01alpha"
  resource_group_name      = azurerm_resource_group.app_alpha_node.name
  location                 = azurerm_resource_group.app_alpha_node.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_app_service_plan" "function_app_plan" {
  name                = "function-app-plan-nodealpine"
  location            = azurerm_resource_group.app_alpha_node.location
  resource_group_name = azurerm_resource_group.app_alpha_node.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }

}

resource "azurerm_function_app" "functionapp_12340012" {
  name                       = "functionapp12340012-alpha"
  location                   = azurerm_resource_group.app_alpha_node.location
  resource_group_name        = azurerm_resource_group.app_alpha_node.name
  app_service_plan_id        = azurerm_app_service_plan.function_app_plan.id
  storage_account_name       = azurerm_storage_account.functionstore_0898891.name
  storage_account_access_key = azurerm_storage_account.functionstore_0898891.primary_access_key
   os_type             = "linux"
  version             = "~4"

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME         = "node"
    FUNCTIONS_EXTENSION_VERSION      = "~4"
    WEBSITE_NODE_DEFAULT_VERSION     = "14.21.3"
  }

  site_config {
    linux_fx_version = "NODE|4.23.0.0"
  }

}


locals {
  resource_group = "app-alpha-node"
  location = "East US"
}

# resource "azurerm_resource_group" "Alpha" {
#     name = local.resource_group
#     location = local.location
# }


# resource "azurerm_storage_account" "Alpha_2bdf" {
#     name = "alpha2bdf"
#     resource_group_name = azurerm_resource_group.Alpha.name
#     location = local.location
#     account_tier = "Standard"
#     account_replication_type = "LRS"
#     account_kind = "StorageV2"
# }

# resource "azurerm_app_service_plan" "function_app_plan" {
#   name                = "function-app-plan"
#   location            = azurerm_resource_group.Alpha.location
#   resource_group_name = azurerm_resource_group.Alpha.name
  

#   sku {
#     tier = "Standard"
#     size = "S1"
#   }
# }


# resource "azurerm_function_app" "functionappazureevent" {
#     name = "functionappazureevent"
#     location = azurerm_resource_group.Alpha.location
#     resource_group_name = azurerm_resource_group.Alpha.name
#     app_service_plan_id = azurerm_app_service_plan.function_app_plan.id
#     storage_account_name = azurerm_storage_account.Alpha_2bdf.name
#     storage_account_access_key = azurerm_storage_account.Alpha_2bdf.primary_access_key
#     os_type = "linux"
#      version = "~4"

#     app_settings = {
#       FUNCTIONS_WORKER_RUNTIME = "node"
#       FUNCTIONS_EXTENSION_VERSION = "~4"
#       WEBSITE_NODE_DEFAULT_VERSION = "14.21.3"
#     }
    
  
# }