#!/usr/bin/perl
#
#        Copyright (C) 2000-2019 the YAMBO team
#              http://www.yambo-code.org
#
# Authors (see AUTHORS file for details): AM
#
# This file is distributed under the terms of the GNU
# General Public License. You can redistribute it and/or
# modify it under the terms of the GNU General Public
# License as published by the Free Software Foundation;
# either version 2, or (at your option) any later version.
#
# This program is distributed in the hope that it will
# be useful, but WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.
#
# You should have received a copy of the GNU General Public
# License along with this program; if not, write to the Free
# Software Foundation, Inc., 59 Temple Place - Suite 330,Boston,
#
use lib ".";
#
use List::MoreUtils 'true';
use Getopt::Long;
use File::Find;
use File::Spec;
use File::Copy;
use File::Basename;
use File::Compare;
use Cwd 'abs_path';
#
use autodie;
#
# pwd
#
$pwd=abs_path();
#
# Options list
&GetOptions("help"           => \$help,
            "install"        => \$install,
            "clean"          => \$clean,
            "list"           => \$list) or die;
sub usage {

 print <<EndOfUsage

   Syntax: tutorials.pl <ARGS>

   where <ARGS> must include at least one of:
                   -h                      This help
                   -list                   List the available tutorials
                   -install                Download & install the core databases
                   -clean                  Clean the repository (remove all execution files)

EndOfUsage
  ;
  exit;
}
#
if($help or (not $install and not $list and not $clean)){ usage };
#
my $ONLINE_tutorials_files_location="educational/tutorials/files";
$main_dir=abs_path();
#
# CLEAN
#=======
if ($clean) {
 system("git ls-files --others --exclude-standard | xargs rm -fr");
 system("git clean -f -d");
}
#
# LIST
#======
if ($list or $install) {
 if ($list) {print "\nAvailable local tutorials:\n\n"};
 &TUTORIALS_list;
# open(ML,"<","LIST");
# @online = <ML>;
# #print @online;
# close(ML);
# system("rm -f LIST");
# $N=0;
 foreach $dir (@tutorials) {
  $N++;
  $tgz=$dir.".tar.gz";
  if ($list) 
  {
   @dirs = ( "./$dir");
   @files = ();
   find( sub { push @files, $File::Find::name if /SAVE/ }, @dirs );
   foreach $dirr (@files)
   {
    $SAVE_dir=$dirr;
    $SAVE_dir =~ s/SAVE//g;
    if (-f $SAVE_dir."/.AUTOMATIC") {$auto =1};
   }
   print " $N: $dir";
   print "\n";
  }
  elsif ($install) 
  {
   $tutorial=$dir;
   &NAME_it;
   &DOWNLOAD_it;
  }
 }
 if ($install and -d "tutorials") {system("rmdir -p tutorials")};
}

print "\nDone.\n";
 
sub TUTORIALS_list
{
@tutorials;
foreach $dir (<*>) {
 if (-d $dir and not ($dir =~ "archive" or $dir =~ /bin/ or $dir =~ /Pseudo/)){
  push @tutorials, $dir;
 }
}
}
#
sub NAME_it{
$DBs_tutorial_tar="${tutorial}_DBs.tar";
$ALL_tutorial_tar="${tutorial}.tar";
$DBs_tutorial_archive="${tutorial}_DBs.tar.gz";
$ALL_tutorial_archive="${tutorial}.tar.gz";
}
#
sub DOWNLOAD_it
{
 chdir("./archive");
 system("wget -c www.yambo-code.org/${ONLINE_tutorials_files_location}/${DBs_tutorial_archive}");
 if (-f  ${DBs_tutorial_archive} ){
  system("cp ${DBs_tutorial_archive} $pwd");
  chdir("$pwd");
  system("gunzip ${DBs_tutorial_archive}");
  system("tar zxf ${DBs_tutorial_tar} ");
  system("rsync -avzr tutorials/$tutorial/ $tutorial/");
  system("rm -fr ${DBs_tutorial_tar}  tutorials/$tutorial ");
 }
 chdir("$pwd");
}
