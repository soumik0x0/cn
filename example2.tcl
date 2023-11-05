set ns [new Simulator]
set nf [open out2.nam w]

$ns namtrace-all $nf

set node0 [$ns node]
set node1 [$ns node]

set link0 [$ns duplex-link $node0 $node1 10Mb 10ms DropTail]

set tcp0 [new Agent/TCP]
$ns attach-agent $node0 $tcp0

set sink1 [new Agent/TCPSink]
$ns attach-agent $node1 $sink1
$ns connect $tcp0 $sink1

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

$ns at 0.1 "$ftp0 start"
$ns at 5.0 "$ftp0 stop"

$ns at 6.0 "finish"

proc finish { } {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam out2.nam &
    exit 0
}

$ns run

