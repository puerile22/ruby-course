def cat_hat(num)
    hash=Hash.new(0)
    i=1
    while i<=num
	    (1..num).each do |j|
		    hash[j]+=1 if j%i==0
	    end
	    i+=1
    end
    hash.each do |k,v|
	    hash[k]="has hat" if v%2!=0
	    hash[k]="doesn't have hat" if v%2==0
    end
    puts hash
end