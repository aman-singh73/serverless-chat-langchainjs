# Infriqa IaC demo — intentional insecure App Service (safe to delete after test).
# Expected: Create fix PR edits THIS file on the demo branch (in-place diff),
# not a brand-new file on main. Fix: ftps_state = "Disabled" (or FtpsOnly),
# public_network_access_enabled = false.

resource "azurerm_linux_web_app" "infriqa_demo_insecure_app" {
  name                = "infriqa-demo-insecure-app"
  resource_group_name = "rg-infriqa-demo"
  location            = "eastus"
  service_plan_id     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-infriqa-demo/providers/Microsoft.Web/serverFarms/plan-demo"

  # RISK: unrestricted FTPS
  ftps_state = "Disabled"

  # RISK: public network access enabled
  public_network_access_enabled = false

  site_config {
    always_on = true
  }

  tags = {
    purpose = "infriqa-iac-demo-ftps-public"
    delete  = "after-test"
  }
}
