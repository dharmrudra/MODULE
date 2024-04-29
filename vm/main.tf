resource "azurerm_public_ip" "PIP" {
  name                = "frontend-pip"
  resource_group_name = "RUDRA"
  location            = "eastus"
  allocation_method   = "Static"
  sku = "Standard"  
  }
resource "azurerm_network_interface" "frontendNIC" {
  name                = "nic"
  location            = "eastus"
  resource_group_name = "RUDRA"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "subscriptions/0dbae4bd-2b3b-45cf-bbe2-ffbc296b16cd/resourceGroups/RUDRA/providers/Microsoft.Network/virtualNetworks/vn1/subnets/vn1_subnet"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.PIP.id
  }
}
resource "azurerm_linux_virtual_machine" "frontend_" {
  name                = "MACHINE"
  resource_group_name = "RUDRA"
  location            = "eastus"
  size                = "Standard_F2s_v2"
  admin_username      = "RUDRA"
  admin_password ="Deepajali8826@"
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.frontendNIC.id]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb = "30"
    name ="frontend-disk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}