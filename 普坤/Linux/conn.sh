#!/usr/bin/expect
# 设置需要读取的配置文件
set timeout 5
set file [open ips]
while {1} {
    set line [gets $file]
    if {[eof $file]} {
        close $file
        break
    }
    if {$argv == [lindex $line 0]} {
      for {set index 1} {$index < 10 && ""!=[lindex $line $index]} {set index [expr $index + 3]} {
        #puts "index: $index"
        set port [lindex $line $index]
        set user [lindex $line [expr $index + 1]]
        set pass [lindex $line [expr $index + 2]]
        #puts "login $user"
        if {1 < $index} {
          puts "ssh -p $port $user\n"
          send "ssh -p $port $user\n"
        } else {
          spawn ssh -p $port $user
        }
        expect {
          "yes/no" {
            send "yes\n"
            expect {
              "assword" {send "$pass\n"}
            }
          }
          "assword" {send "$pass\n"}
        }
      }
      interact
    }
}
