TripleO Standalone Lab Setup
===========================

Create a VM on a RHEL+KVM hypervisor that is ready to deploy TripleO Standalone

Requirements
------------

- Expects a working RHEL+KVM hypervisor to target
- Either physical virtualization or nested virtualization

Role Variables
--------------

| Variable        | Required | Default  | Description                                                                                                                                                                                                                                     |
| --------------- | -------- | -------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `kvm_vm_hostname` | :heavy_check_mark:      |  | The FQDN for the VM |
| `kvm_vm_public_ip` | :heavy_check_mark:      |  | The reachable public IP for the VM |
| `kvm_vm_root_pwd` | :heavy_check_mark:      |  | Password for the root user of the VM |
| `kvm_vm_base_img` | :heavy_check_mark:      |  | Name of the base image located in /var/lib/libvirt/images on the KVM hypervisor |
| `kvm_vm_vcpus` | :x:      | ```4``` | Number of vCPUS to assign to the VM |
| `kvm_vm_ram` | :x:      | ```8192``` | Amount of ram to give to the VM in megabytes |
| `kvm_vm_os_disk_name` | :x:      | ```{{ kvm_vm_hostname }}``` | Name of the OS disk in /var/lib/libvirt/images |
| `kvm_vm_os_disk_size` | :x:      | ```50G``` | Size of OS disk for the VM |
| `kvm_vm_nics` | :heavy_check_mark:      | ```see example playbook``` | Dictionary of NICs to create for the VM |

Dependencies
------------

None

Example Playbook
----------------

```yaml
- hosts: kvm
  tags: provision
  vars:
    kvm_vm_hostname: "vm1.example.com"
    kvm_vm_public_ip: 192.168.122.10
    kvm_vm_root_pwd: "p@ssw0rd"
    kvm_vm_base_img: CentOS-7-x86_64-GenericCloud.qcow2
    kvm_vm_vcpus: "4"
    kvm_vm_ram: "8192"
    kvm_vm_os_disk_name: "{{ kvm_vm_hostname }}"
    kvm_vm_os_disk_size: "30G"
    kvm_vm_nics:
      - name: eth0
        bootproto: static
        onboot: yes
        ip: "{{ kvm_vm_public_ip }}"
        prefix: "24"
        gateway: "192.168.122.1"
        dns_server: "192.168.122.1"
        config: "--type network --source default --model virtio"
      - name: eth1
        bootproto: static
        onboot: yes
        ip: "192.168.122.253"
        prefix: "24"
        gateway: "192.168.122.1"
        dns_server: "192.168.122.1"
        config: "--type network --source default --model virtio"
  tasks:
    - name: Create KVM VM
      include_role:
        name: tripleo-standalone-lab
```

License
-------

GPLv3

Author Information
------------------
[Red Hat World Wide TripleO Flying Owls](http://tripleo.org/)

[Red Hat North American Public Sector Solution Architects](https://redhatgov.io)
