# Probe default interface

Facter.add("defaultgw_interface") do
  confine :kernel => :linux
  setcode do
    interface = Facter::Util::Resolution.exec('ip route get 1.1.1.1').split("\n")[0]
    if interface
      interface.split(/\s+/)[4].to_s
    else
      nil
    end
  end
end
