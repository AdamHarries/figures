for f in $(ls | grep ".*.sql" | sed "s/.sql//g"); do
	echo "Running sql file: $f.sql"
	mysql -B -us1467120 -paiamaRNGOOG -h phantom.inf.ed.ac.uk s1467120 < $f.sql > $f.csv 
done