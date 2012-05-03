# -*- mode: ruby -*-                                                                                                                                                         
# vi: set ft=ruby :                                                                                                                                                          

Vagrant::Config.run do |config|                                                                                                                                              
  # All Vagrant configuration is done here. The most common configuration                                                                                                    
  # options are documented and commented below. For a complete reference,                                                                                                    
  # please see the online documentation at vagrantup.com.                                                                                                                    

  # Every Vagrant virtual environment requires a box to build off of.                                                                                                        
  config.vm.box = "lucid64"                                                                                                                                                  

  # The url from where the 'config.vm.box' box will be fetched if it                                                                                                         
  # doesn't already exist on the user's system.                                                                                                                              
  config.vm.box_url = "http://files.vagrantup.com/lucid64.box"                                                                                                                                                                                                                                                                                                                       

  # Assign this VM to a host-only network IP, allowing you to access it                                                                                                      
  # via the IP. Host-only networks can talk to the host machine as well as                                                                                                   
  # any other machines on the same network, but cannot be accessed (through this                                                                                             
  # network interface) by any external networks.                                                                                                                             
  #config.vm.network :hostonly, "33.33.33.10"

	config.vm.forward_port 3000, 3000

  config.vm.provision :chef_solo do |chef|     
    chef.cookbooks_path = ["cookbooks","cookbooks-src"]                                                                                                                      

    chef.add_recipe "apt"
		chef.add_recipe "build-essential"
		chef.add_recipe "rvm::vagrant"
		chef.add_recipe "rvm::system"
		chef.add_recipe "git"

  end                                                                                                                                                                        

end  