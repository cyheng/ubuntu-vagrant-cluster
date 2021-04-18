[ ! -f ~/.ssh/id_rsa.pub ] && ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa &>/dev/null  
while read line;do
        if [ -z "$line" ];then
           break
        fi
        ip=`echo $line | cut -d " " -f1`            
        user_name=`echo $line | cut -d " " -f2`    
        pass_word=`echo $line | cut -d " " -f3`     
expect <<EOF
        spawn ssh-copy-id  $user_name@$ip    
        expect {
                "yes/no" { send "yes\n";exp_continue}      
                "password" { send "$pass_word\n"}
        }
        expect eof
EOF
done < ~/host_ip.txt     

