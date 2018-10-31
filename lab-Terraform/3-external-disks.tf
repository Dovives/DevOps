resource "azurerm_managed_disk" "external" {
  name                 = "${var.prefix}-disk${count.index+1}"
  count                = "${var.number_of_disks}"
  location             = "${azurerm_resource_group.main.location}"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "10"
}

resource "azurerm_virtual_machine_data_disk_attachment" "external" {
  count              = "${var.number_of_disks}"
  managed_disk_id    = "${azurerm_managed_disk.external.id}"
  virtual_machine_id = "${azurerm_virtual_machine.main.id}"
  lun                = "${10+count.index}"
  caching            = "ReadWrite"
}