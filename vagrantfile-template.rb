# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

$env = YAML::load_file('vagrant-hosts.yml')

Vagrant.configure('2') do |config|

    # Local name resolution via the vagrant-hostmanager plugin
    if Vagrant.has_plugin?("vagrant-hostmanager")
        config.hostmanager.enabled = true
        config.hostmanager.manage_host = true
        config.hostmanager.ignore_private_ip = false
        config.hostmanager.include_offline = true
    end

    # Create and provision each host as defined in the vagrant YAML file
    $env['hosts'].each do |host_name, host_config|
        config.vm.define host_name do |host|

            # Host
            host.vm.box = host_config['box']
            host.vm.host_name = "#{host_name}.local"
            
            if Vagrant.has_plugin?("vagrant-hostmanager")
                host.hostmanager.aliases = ["#{host_name}"]
            end

            # Private Networks
            if host_config['private_networks']
                host_config['private_networks'].each do |private_network|
                    host.vm.network 'private_network', :ip => private_network['private_ip']
                end
            end

            # Synced Folders
            if host_config['synced_folders']
                host_config['synced_folders'].each do |synced_folder|
                    host.vm.synced_folder synced_folder['host_path'],
                                          synced_folder['guest_path'],
                                          :disabled => synced_folder['disabled']
                end
            end

            # Port forwarding
            if host_config['ports']
                host_config['ports'].each do |port|
                    host.vm.network 'forwarded_port',
                                    :host => port['host_port'],
                                    :guest => port['guest_port'],
                                    :protocol => port['protocol']
                end
            end

            # VirtualBox config
            host.vm.provider :virtualbox do |vbox|
                if host_config['memory']
                    vbox.customize ['modifyvm', :id, '--memory',
                                    host_config['memory']]
                end
                vbox.customize ['modifyvm', :id, '--usb', 'off']
            end

            # VMware config
            host.vm.provider :vmware_fusion or host.vm.provider :vmware_desktop do |vmware|
                if host_config['memory']
                    vmware.vmx['memsize'] = host_config['memory']
                end
                vmware.vmx['numvcpus'] = '1'
                vmware.vmx['virtualHW.version'] = '11'
                vmware.vmx['vhv.enable'] = 'TRUE'
                vmware.gui = false
            end
        end
    end
end
