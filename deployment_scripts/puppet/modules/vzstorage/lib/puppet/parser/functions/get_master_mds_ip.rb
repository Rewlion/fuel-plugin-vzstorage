Puppet::Parser::Functions::newfunction(:get_master_mds_ip, :type => :rvalue, :arity => 1, :doc => <<-EOS
	This function gets hash with MDS storage ips 
	Returns storage ip of master MDS
	EOS
	) do |argv|
	ips = argv[0]
	ips.sort! { |a,b| a.split('.')[3].to_i <=> b.split('.')[3].to_i }
	return ips[0]
end
