# -*- mode: ruby -*-
# vi: set ft=ruby :

#
# File     : Vagrantfile
# License  :
#   The MIT License (MIT)
#
#   Copyright (c) 2016 Herdy Handoko
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in
#   all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#   THE SOFTWARE.
#

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------
CFG_HOSTNAME = ENV['VM_NAME'] || "diskusi-svcs0" # Guest VM name
CFG_MEMSIZE = ENV['VM_MEM'] || "1024"            # Allocated max RAM
CFG_CPU_COUNT = ENV['VM_CPU'] || "1"             # Allocated CPU core(s)
CFG_IP = ENV['VM_IP'] || "192.168.10.10"         # Assigned static IP address



# -----------------------------------------------------------------------------
# Vagrant Script
# -----------------------------------------------------------------------------
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Use Ubuntu 14.04 LTS (Trusty Tahr) from Ubuntu repository
  config.vm.box = "trusty64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  # Use `vagrant-cachier` to cache common packages and reduce time to provision boxes
  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
  end

  config.vm.host_name = CFG_HOSTNAME
  config.vm.network :private_network, ip: CFG_IP

  # Run provisioning script
  config.vm.provision :shell, :path => "tools/vagrant/postgresql.sh"

  # Configure guest VM port forwarding
  config.vm.network :forwarded_port, guest: 5432, host: 15432

  # Configure guest VM memory size
  config.vm.provider :virtualbox do |v|
    v.name = CFG_HOSTNAME
    v.customize ["modifyvm", :id, "--memory", CFG_MEMSIZE, "--cpus", CFG_CPU_COUNT]
  end

end