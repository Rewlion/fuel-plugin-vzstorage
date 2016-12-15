Puppet::Parser::Functions::newfunction(:prepare_cgroups_hash, :type => :rvalue, :arity => 1, :doc => <<-EOS
    This function gets device and returns it's uuid
    throws an exception in case of bad device name

    Example:
      uuid = get_dev_uuid('/dev/sda')
      #now uuid contains f3fbcbb8-4224-4a6a-89ed-3c55bbc073e0
    EOS
  ) do |argv|
  
  device = argv[0].sub(/^(\/dev\/)/,'')
  tmp    = %x( ls -al /dev/disk/by-uuid/ | grep #{device} )
  
  throw "bad device name: #{device}" if tmp.to_s == ''

  tmp    = tmp.split(' ')
  uuid   = tmp[5]

  uuid
end