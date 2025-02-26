output "VM_names_and_IPs" {

  value = [
    { VM1 = ["instance_name: ${yandex_compute_instance.platform.name}","fqdn: ${yandex_compute_instance.platform.fqdn}","extenal_ip: ${yandex_compute_instance.platform.network_interface[0].nat_ip_address}"]},
    { VM2 = ["instance_name: ${yandex_compute_instance.platform-db.name}","fqdn: ${yandex_compute_instance.platform-db.fqdn}","extenal_ip: ${yandex_compute_instance.platform-db.network_interface[0].nat_ip_address}"]},
   ]
}
