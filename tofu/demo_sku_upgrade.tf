# Demo: App Service Plan SKU Standard (S1)  upgrade to Premium (P1v2)
resource "azurerm_service_plan" "demo_sku" {
  name                = "plan-demo-sku"
  resource_group_name = "rg-infriqa-demo"
  location            = "eastus"
  os_type             = "Linux"
  sku_name            = "P1v2"
}
