for i in {1..432} ; do echo -n "Speed test $i "; date +"%FT%T" >> time_series ; speedtest >> speedtests ; sleep 300 ; done
