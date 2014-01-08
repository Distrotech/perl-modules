DESTDIR=/root/.cpan/perlmods
PREFIX=/usr
PERLLOCAL=$(DESTDIR)$(PREFIX)

ARCH=default

LOCMODS=DB_File_mod IO-Socket-INET6_mod IO-Socket-SSL_mod NetAddr-IP_mod Mail-SpamAssassin_mod

CPAN_MODS=XML\:\:Parser XML\:\:SAX Font\:\:TTF XML\:\:Simple Archive\:\:Zip Pod\:\:Simple\:\:Search YAML File\:\:Temp \
		IO\:\:HTML NET\:\:HTTP Term\:\:ReadKey Text\:\:WrapI18N Unicode\:\:GCString Net\:\:DNS Digest\:\:SHA1 \
		Time\:\:Zone URI NET\:\:HTTP Mail\:\:Send Mail\:\:SPF IP\:\:Country  Razor2 Net\:\:Ident Mail\:\:DKIM DBI \
		HTTP\:\:Daemon Geography\:\:Countries LWP LWP\:\:MediaTypes Encode\:\:Detect XML\:\:SAX\:\:Expat XML\:\:SAX\:\:Base \
		HTTP\:\:Cookies HTTP\:\:Request Net\:\:DNS\:\:Resolver\:\:Programmable File\:\:Listing IO\:\:String XML\:\:NamespaceSupport \
		WWW\:\:RobotRules POD2\:\:JA MIME\:\:Charset HTML\:\:Tagset Net\:\:HTTP\:\:Methods Encode\:\:Locale Digest\:\:HMAC \
		HTML\:\:Parser Text\:\:CharWidth Crypt\:\:OpenSSL\:\:Random Crypt\:\:OpenSSL\:\:RSA HTTP\:\:Date HTTP\:\:Negotiate

all:
	echo "There is no all target run make install"

cpan.mods: $(CPAN_MODS)
	touch cpan.mods

local.mods: cpan.mods $(LOCMODS)

install: cpan.mods local.mods

Mail-SpamAssassin_mod:
	export PERL5LIB=$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/:$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/x86_64-linux-gnu-thread-multi:$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/x86_64-linux-gnu-thread-multi/auto; \
	cd $(subst _mod,, $@) && git clean -x -f -d && perl Makefile.PL CONTACT_ADDRESS="the administrator of that system" && make && make DESTDIR=$(DESTDIR) install

DB_File_mod:
	cd $(subst _mod,, $@) && ./config.sh $(ARCH) git clean -x -f -d && perl Makefile.PL && make && make DESTDIR=$(DESTDIR) install

%_mod:
	cd $(subst _mod,, $@) && git clean -x -f -d && perl Makefile.PL && make && make DESTDIR=$(DESTDIR) install

clean:
	rm cpan.mods
	for loc_mod in $(LOCMODS);do \
	  cd $(subst _mod,, $${loc_mod}) && if [ -f Makefile ];then make $@;fi \
	done;

distclean: clean
	for loc_mod in $(LOCMODS);do \
	  cd $(subst _mod,, $${loc_mod}) && if [ -f Makefile ];then make $@;fi \
	done;


%: 
	export PERL5LIB=$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/:$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/x86_64-linux-gnu-thread-multi:$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/x86_64-linux-gnu-thread-multi/auto; \
	cpan -j cpan.cfg -ifT $@
