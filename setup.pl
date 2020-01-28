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
use Getopt::Long;
use File::Find;
use File::Spec;
use File::Basename;
use Cwd 'abs_path';
#
# pwd
#
$pwd=abs_path();
#
# Options list
&GetOptions("help"           => \$help,
            "install:s"      => \$install,
            "clean"          => \$clean,
            "more"           => \$more,
            "list"           => \$list) or die;
sub usage {

 print <<EndOfUsage

   Syntax: tutorials.pl <ARGS>

   where <ARGS> must include at least one of:
                   -h                      This help
                   -list                   List the available tutorials
                   -install [TUTORIAL]     Download & install the core databases. A specific [TUTORIAL] can be provided. 
                                           If empty all tutorials are downloaded.
                   -clean                  Clean the repository (remove all execution files)
                   -more                   Download more tutorials (in addition to the basic ones)

EndOfUsage
  ;
  exit;
}
#
my $len= length($install);
if ($len eq 0) {$install="all"};
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
 foreach $dir (@tutorials) {
  undef $more_tut;
  $N++;
  $tgz=$dir.".tar.gz";
  if (-f $dir."/.more") {$more_tut =1};
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
   if (not $more_tut) {print " $N: $dir"};
   if (    $more_tut) {print " $N: $dir (additional)"};
   print "\n";
  }
  elsif ($install) 
  {
   if ($more_tut and not $more ) {next};
   $tutorial=$dir;
   &NAME_it;
   if ("${install}_DBs.tar" =~ "$DBs_tutorial_tar" or "$install" =~ "all") { &DOWNLOAD_it };
  }
 }
 if ($install and -d "tutorials") {system("rmdir -p tutorials")};
}

print "\nDone.\n";
#
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
$DBs_tutorial_archive="${tutorial}_DBs.tar.gz";
}
#
sub DOWNLOAD_it
{
 chdir("./archive");
 system("rm -f ${DBs_tutorial_archive}");
 system("wget www.yambo-code.org/${ONLINE_tutorials_files_location}/${DBs_tutorial_archive}");
 if (-f ${DBs_tutorial_archive} ){
  system("gunzip ${DBs_tutorial_archive}");
  chdir("$pwd");
  system("tar xf archive/${DBs_tutorial_tar} ");
  system("gzip archive/${DBs_tutorial_tar}");
 }
 chdir("$pwd");
}
