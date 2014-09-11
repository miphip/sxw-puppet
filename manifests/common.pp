class sxw::common {
  package { 'python-software-properties': }
  package {
    'subversion':;
    'git':;
    'openssh-server':;
    'zip':;
    'samba':;
    'bison':;
    'gettext':;
    'flex':;
    'libncurses5-dev':;
    'manpages-dev':;
    'build-essential':;
    'fakeroot':;
    'rsh-client':;
    'texinfo':;
    'language-pack-en':;
    'valgrind':;
    'quilt':;
    'automake':;
    'binutils-dev':;
    'gawk':;
    'texlive':;
    'texlive-latex-extra':;
    'openjdk-7-jdk':;
    'python3':;
    'perl':;
    'python-dev':;
    'gcc-4.6':;
    'g++-4.6':;
    'liblua5.1-0-dev':;
    'libusb-1.0-0-dev':;
    'libssh2-1-dev':;
    'libssl-dev':;
    'smbclient':;
    'libcap-dev':;
    'libc6-i386':;
    'libusb-dev':;
    'python-virtualenv':;
    'libxslt1.1':;
    'python3-pyqt5':;
    'python3-sip':;
  }

  class { 'sxw::nfssetup':
    user => 'ci',
  }

  include sxw::mknod
}
