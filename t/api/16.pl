#!/usr/bin/perl

use lib '/home/liuxiaojing/code/repos/openQA/lib/';
use OpenQA::Settings;
use Data::Dumper;

my %jobs_post_params = (
    iso      => 'openSUSE-%VERSION%-%FLAVOR%-%ARCH%-Current.iso',
    DISTRI   => 'opensuse',
    VERSION  => 'Tumbleweed',
    FLAVOR   => 'DVD',
    TEST     => 'awesome',
    MACHINE  => '64bit',
    BUILD    => '1234',
    _GROUP   => 'opensuse',
    ARCH     => 'x86_64',
    BUILD_HA => '%BUILD%',
    BUILD_SDK => '1234',
    PUBLISH_HDD_1 => 'SLES-%VERSION%-%ARCH%-%BUILD%@%MACHINE%-minimal_with_sdk%BUILD_SDK%_installed.qcow2',
    PUBLISH_PFLASH_VARS => 'SLES-%VERSION%-%ARCH%-%BUILD%@%MACHINE%-minimal_with_sdk%BUILD_SDK%_installed-uefi-vars.qcow2',
);

my $settings = OpenQA::Settings->new(%jobs_post_params)->expand_placeholders();

print Dumper(\%jobs_post_params);
print "\n";

print Dumper($settings);
