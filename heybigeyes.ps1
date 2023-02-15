#written by peroxide/aegir/goddamn devil soul hacker shin megami tensei man i avhe't gotten a good sleep in a couple 
#windows inventory script for CCDC 2023 * 
#thanks to ivan n ethan 4 help w this shit , borrowed all tcp connections from ethannnn (xfaraday)
# loss=gain draiiin ganggg
Write-Host "*****************************************************************"
Write-Host "loss and gain is the same"
Write-Host "written by friday kriedeman"
Write-Host "vers .1"
Write-Host " "
"

                  __,
               .-'_-'`
             .' {`
         .-'````'-.    .-'``'.
       .'(0)       '._/ _.-.  `\
      }     '. ))    _<`    )`  |
       `-.,\'.\_,.-\` \`---; .' /
            )  )       '-.  '--:
           ( ' (          ) '.  \
            '.  )      .'(   /   )
              )/      (   '.    /
                       '._( ) .'
                    jgs    ( (
                            `-.


"

$hostbody = @()


$namae = hostname

$hostbody += [PSCustomObject]@{
            hostName = $tranq
        } 

$localusers = (Get-LocalUser).Name 
$localusers
$hostbody += [PSCustomObject]@{
            localusers = $localusers
        }


 if (Get-command Get-NetTCPConnection -errorAction SilentlyContinue) {
        $proclist = (get-nettcpconnection | ? {$_.State -eq 'Listen'}).OwningProcess
	    $tcpcon = @()
	    $i = 1
	    foreach ($proc in $proclist) {
    	    Write-Progress -Activity "TcpConnection" -Status "Filling New Object tcpcon" -PercentComplete (($i / $proclist.Count) * 100)
    	    $procname = (Get-Process -PID $proc).ProcessName
            $procpath = (Get-Process -PID $proc).Path
    	    $port = (Get-NetTCPConnection | ? {$_.OwningProcess -eq $proc}).LocalPort
    	    $tcpcon += [PSCustomObject]@{
        	    'Name' = $procname
        	    'ProcessId' = $proc
        	    'Port' = $port
                'Path to bin' = $procpath
    	    } 
            $i++
        }
        $tcpcon | sort Name | ft -AutoSize
        $hostbody += [PSCustomObject]@{
            TcpConnection = $tcpcon
        }
    } else {
        $tcpcon = netstat -ano | findstr LISTENING
        $hostbody += [PSCustomObject]@{
            TcpConnection = $tcpcon
        }
    }



$ips = ipconfig | findstr IPv4 
$ips
$hostbody += [PSCustomObject]@{
            Ips = $ips
        }

$servingc = service | findstr Running
$servingc
$hostbody += [PSCustomObject]@{
            service = $servingc
        }
$taskmaster = tasklist 
$taskmaster
$hostbody += [PSCustomObject]@{
            tasks = $taskmaster
        }
        echo "connections" >> smoke.txt

$tcpcon | Out-File -Append smoke.txt
echo "tasks" >> smoke.txt

$taskmaster | Out-File -Append smoke.txt
echo "services" >> smoke.txt

$servingc | Out-File -Append smoke.txt
echo "ips" >> smoke.txt

$ips | Out-File -Append smoke.txt
echo "hostname" >> smoke.txt

$namae | Out-File -Append smoke.txt
echo "ussers" >> smoke.txt

$localusers | Out-File -Append smoke.txt





#winspecific inventory scripts  will be stored in sunset.txt
$acetone = @()


$frwll = get-netfirewallprofile 
$frwll
$acetone += [PSCustomObject]@{
            firewallprofile = $frwll
        }
$PSVersionTable 
$acetone += [PSCustomObject]@{
            pwrshellVersiontbl = $PSVersionTable 
        }




$defndr = Get-MpComputerStatus 
$defndr
$acetone += [PSCustomObject]@{
            defndrStatus = $defndr
        }


$acetone
$hostbody
$acetone  | Export-Csv smoke.csv
$hostbody | Export-Csv sunset.csv
echo "defender" >> smoke.txt

$defndr | Out-File -Append sunset.txt
echo "powrshell" >> smoke.txt

$PSVersionTable | Out-File -Append sunset.txt
echo "firewall" >> smoke.txt

$frwll | Out-File -Append sunset.txt

