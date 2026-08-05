resource "azurerm_cosmosdb_sql_database" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  account_name        = var.account_name
  throughput          = var.throughput

  dynamic "autoscale_settings" {
    for_each = var.autoscale_settings != null ? [var.autoscale_settings] : []
    content {
      max_throughput = autoscale_settings.value.max_throughput
    }
  }
}



