PREFIX=/usr

PERLTMP=/root/.cpan/perlmods
PERLLOCAL=$(PERLTMP)/$(PREFIX)
PARCH=$(shell eval `perl -V:archlib`;basename $${archlib})
PERLBLIB=$(PERLLOCAL)/lib/perl5/site_perl/5.18.1
PERLALIB=$(PERLBLIB)/$(PARCH)
PERL5LIB=$(PERLBLIB)/:$(PERLABLIB):$(PERLALIB)/auto

ARCH=default

LOCMODS= DB_File_mod IO-Socket-INET6_mod IO-Socket-SSL_mod NetAddr-IP_mod Mail-SpamAssassin_mod

CPAN_DEPENDS =	IO\:\:HTML \
		HTTP\:\:Date \
		Encode\:\:Locale \
		URI \
		LWP\:\:MediaTypes \
		HTTP\:\:Message \
		HTTP\:\:Daemon \
		HTML\:\:Tagset \
		HTTP\:\:Negotiate \
		HTTP\:\:Cookies \
		HTML\:\:Parser \
		Net\:\:HTTP \
		WWW\:\:RobotRules \
		File\:\:Listing \
		LWP \
		XML\:\:SAX\:\:Base \
		XML\:\:NamespaceSupport \
		IO\:\:String \
		XML\:\:Parser \
		XML\:\:SAX \
		XML\:\:SAX\:\:Expat \
		Text\:\:CharWidth \
		MIME\:\:Charset \
		Digest\:\:HMAC \
		Net\:\:DNS \
		Digest\:\:SHA1 \
		Net\:\:DNS\:\:Resolver\:\:Programmable \
		Mail\:\:SPF \
		Geography\:\:Countries \
		IP\:\:Country  \
		Net\:\:Ident \
		Time\:\:Zone \
		Mail\:\:Send \
		Crypt\:\:OpenSSL\:\:Random \
		Crypt\:\:OpenSSL\:\:RSA \
		Mail\:\:DKIM \
		DBI \
		Encode\:\:Detect \
		HTTP\:\:Request

CPAN_MODS =	Font\:\:TTF \
		XML\:\:Simple \
		Archive\:\:Zip \
		Pod\:\:Simple\:\:Search \
		YAML \
		File\:\:Temp \
		Term\:\:ReadKey \
		Text\:\:WrapI18N \
		Unicode\:\:LineBreak
#		Razor2 \

all:
	git submodule update --init
	@echo "There is no all target run make install but i did turn on the submodules"

Mail-SpamAssassin_mod:
	@export PERL5LIB=$(PERL5LIB); \
	cd $(subst _mod,, $@) && git clean -x -f -d && perl Makefile.PL CONTACT_ADDRESS="the administrator of that system" && make && make DESTDIR=$(PERLTMP) install && touch ../$@

DB_File_mod:
	cd $(subst _mod,, $@) && ./config.sh $(ARCH) git clean -x -f -d && perl Makefile.PL && make && make DESTDIR=$(PERLTMP) install && touch ../$@

%_mod:
	cd $(subst _mod,, $@) && git clean -x -f -d && perl Makefile.PL && make && make DESTDIR=$(PERLTMP) install && touch ../$@

clean_mods:
	rm -f $(CPAN_DEPENDS) $(CPAN_MODS) $(LOCMODS)

clean: clean_mods
	for loc_mod in $(LOCMODS);do \
	  cd $(subst _mod,, $${loc_mod}) && if [ -f Makefile ];then make $@;fi \
	done;

distclean: clean
	for loc_mod in $(LOCMODS);do \
	  cd $(subst _mod,, $${loc_mod}) && if [ -f Makefile ];then make $@;fi \
	done;

install: $(CPAN_DEPENDS) $(CPAN_MODS) $(LOCMODS)
	@rsync -a $(PERLTMP)/ $(DESTDIR)/

%:
	@export PERL5LIB=$(PERL5LIB); \
	cpan -j cpan.cfg -ifT $@ && touch $@

.notparallel:
.phony: install all clean distclean clean_mods
