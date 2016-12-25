Puppet::Parser::Functions::newfunction(:get_mds_ips, :type => :rvalue, :arity => 1, :doc => <<-EOS
    This function gets hash with nodes
    and returns their array with their ips
    EOS
  ) do |argv|
  nodes       = argv[0]
  mds_role    = ['vzstorage-mds-master', 'vzstorage-mds-slave']
  ips         = []
  for i in (0...nodes.size.to_i) do 
    if nodes[i]['role'] in mds_role then
      ips.push nodes[i]['storage_address']
    end
  end
  return ips
end