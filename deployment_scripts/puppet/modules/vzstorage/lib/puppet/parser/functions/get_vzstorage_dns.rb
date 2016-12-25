Puppet::Parser::Functions::newfunction(:get_vzstorage_dns, :type => :rvalue, :arity => 1, :doc => <<-EOS
    This function gets hash with nodes
    and returns dns ip
    EOS
  ) do |argv|
  nodes       = argv[0]
  mds_role    = 'vzstorage-mds-master'
  ips         = ""
  for i in (0...nodes.size.to_i) do 
    if nodes[i]['role'] == mds_role then
      return nodes[i]['role']['storage_address']
    end
  end
  throw "no master mds has been found"
end