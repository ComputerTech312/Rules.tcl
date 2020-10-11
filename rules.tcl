#############################################
# Rules.tcl 1.0                             #
#############################################
#Creator ComputerTech                       #
#Irc     irc.technet.xi.ht #ComputerTech    #
#Email   ComputerTech312@Gmail.com          #
#GitHub  https://github.com/computertech312 #
#################################################################################################################################################################
#Commands                                   #
#!rules                                     #
#!giverules                                 #
#############################################
#Start Of Settings

#Trigger

set pubcmd ";"

#Flags 

set flag "-|-"

#Seconds per usage 

set flood "60"

#Channel Rules

set chanrules {
"----------------------------------------------------"
"#ComputerTech Rules and Policy"
"1. No Flooding,Spamming Or Any Attacks"
"2. No Advertising"
"3. Never Question The Staff"
"4. No Harrasing or Bullying"
"5. No Sexual Conversations nor Actions"
"6. What happens outside #ComputerTech, Stays outside it"
"7. We hold no responsibility, of what happens inside #ComputerTech" 
"8. All rules and actions, can either be slackened or strengthened to the descrition of Staff"
"----------------------------------------------------"
}

#################################################################################################################################################################

proc throttled {id seconds} {
   global throttle
   if {[info exists throttle($id)]&&$throttle($id)>[clock seconds]} {
      set id 1
   } {
      set throttle($id) [expr {[clock seconds]+$seconds}]
      set id 0
   }
}
# delete expired entries every 10 minutes
bind time - ?0* throttledCleanup
proc throttledCleanup args {
   global throttle
   set now [clock seconds]
   foreach {id time} [array get throttle] {
      if {$time<=$now} {unset throttle($id)}
   }
} 


bind pub ${flag} ${pubcmd}rules ask:rules
proc ask:rules {nick uhost hand chan text} {
global chanrules flood throttled

if {[throttled $uhost,$chan $flood]} {
return
}

foreach line $chanrules {putserv "NOTICE $nick :$line" }
}

bind pub ${flag} ${pubcmd}giverules give:rules
proc give:rules {nick uhost hand chan text} {
global chanrules flood throttled

if {[throttled $uhost,$chan $flood]} {
return
}


set nrule [lindex [split $text] 0 ]
foreach line $chanrules {putserv "NOTICE $nrule :$line" }
}

#################################################################################################################################################################
