Vagrant.configure("2") do |config|

  config.vm.define :node1 do |role|
    role.vm.network   :private_network, ip: "192.168.251.100"
    role.vm.box      = "ceph_base"
    role.vm.hostname = "node1"

    role.vm.provider 'virtualbox' do |vm|
      # Attach virtual disk to node
      disk_file = Pathname.new(__FILE__).join('..', 'node1.vmdk')

      vm.customize ['createhd', 
                    '--filename', disk_file, 
                    '--size', 2048] unless File.exist?(disk_file)

      vm.customize ['storageattach', 
                    :id, '--storagectl', 
                    'SATA Controller', 
                    '--port', 1, 
                    '--device', 0, 
                    '--type', 'hdd', 
                    '--medium', disk_file]
    end


    role.vm.provision :shell, :path => "setup/node1.sh"
  end


  config.vm.define :client do |role|
    role.vm.network   :private_network, ip: "192.168.251.101"
    role.vm.box      = "ceph_base"
    role.vm.hostname = "client"

    role.vm.provision :shell, :path => "setup/client.sh"
  end

end
