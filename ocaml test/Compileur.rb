modules = File.open("Order.txt" ,'r'){|i| i.read}.split("\n").map{|i| i.strip}
modules.each do |i| 
	IO.popen("ocamlopt -c #{i}.ml")
	sleep(1)
end
liste = modules.map{|i| "#{i}.cmx"}.join(" ")
pipe = IO.popen("ocamlopt -o Output #{liste}")
