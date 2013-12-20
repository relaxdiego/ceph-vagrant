Vagrant.configure("2") do |config|

  config.vm.define :node1 do |role|
    role.vm.network   :private_network, ip: "192.168.251.100"
    role.vm.box      = "ceph_base"
    role.vm.hostname = "server"

    role.vm.provision :shell, :path => "setup/server.sh"
  end


  config.vm.define :client do |role|
    role.vm.network   :private_network, ip: "192.168.251.101"
    role.vm.box      = "ceph_base"
    role.vm.hostname = "client"

    role.vm.provision :shell, :path => "setup/client.sh"
  end

end
