DESTDIR=/root/.cpan/perlmods
PREFIX=/usr
PERLLOCAL=$(DESTDIR)$(PREFIX)

ARCH=default

LOCMODS=DB_File_mod IO-Socket-INET6_mod IO-Socket-SSL_mod NetAddr-IP_mod Mail-SpamAssassin_mod

CPAN_MODS=XML\:\:Parser XML\:\:SAX Font\:\:TTF XML\:\:Simple Archive\:\:Zip Pod\:\:Simple\:\:Search YAML File\:\:Temp \
		Term\:\:ReadKey Text\:\:WrapI18N Unicode\:\:GCString Net\:\:DNS Digest\:\:SHA1 \
		Mail\:\:SPF IP\:\:Country  Razor2 Net\:\:Ident Mail\:\:DKIM DBI \
		Encode\:\:Detect

all: $(CPAN_MODS) $(LOCMODS)

Mail-SpamAssassin_mod:
	export PERL5LIB=$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/:$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/x86_64-linux-gnu-thread-multi:$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/x86_64-linux-gnu-thread-multi/auto; \
	cd $(subst _mod,, $@) && git clean -x -f -d && perl Makefile.PL CONTACT_ADDRESS="the administrator of that system" && make && make DESTDIR=$(DESTDIR) install

DB_File_mod:
	cd $(subst _mod,, $@) && ./config.sh $(ARCH) git clean -x -f -d && perl Makefile.PL && make && make DESTDIR=$(DESTDIR) install

%_mod:
	cd $(subst _mod,, $@) && git clean -x -f -d && perl Makefile.PL && make && make DESTDIR=$(DESTDIR) install

clean:
	for loc_mod in $(LOCMODS);do \
	  cd $(subst _mod,, $${loc_mod}) && if [ -f Makefile ];then make $@;fi \
	done;

distclean:
	for loc_mod in $(LOCMODS);do \
	  cd $(subst _mod,, $${loc_mod}) && if [ -f Makefile ];then make $@;fi \
	done;


%: 
	export PERL5LIB=$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/:$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/x86_64-linux-gnu-thread-multi:$(PERLLOCAL)/lib/perl5/site_perl/5.18.1/x86_64-linux-gnu-thread-multi/auto; \
	cpan -ifT $@
