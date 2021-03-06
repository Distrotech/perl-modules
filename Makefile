PREFIX=/usr

PERLTMP=/root/.cpan/perlmods
PERLLOCAL=$(PERLTMP)/$(PREFIX)
PARCH=$(shell eval `perl -V:archlib`;basename $${archlib})
PERLBLIB=$(PERLLOCAL)/lib/perl5/site_perl/5.22.0
PERLALIB=$(PERLBLIB)/$(PARCH)
PERL5LIB=$(PERLBLIB)/:$(PERLABLIB):$(PERLALIB)/auto

ARCH=default

LOCMODS= DB_File_mod IO-Socket-INET6_mod IO-Socket-SSL_mod NetAddr-IP_mod Mail-SpamAssassin_mod DBD-mysql_mod

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
		Path\:\:Class \
		Crypt\:\:OpenSSL\:\:Random \
		Crypt\:\:OpenSSL\:\:RSA \
		Mail\:\:DKIM \
		DBI \
		Encode\:\:Detect \
		HTTP\:\:Request \
		Convert\:\:BinHex \
		Convert\:\:TNEF \
		DBD\:\:SQLite \
		DBD\:\:ODBC \
		Filesys\:\:Df \
		IO\:\:Stringy \
		MIME\:\:Tools \
		Net\:\:CIDR \
		Net\:\:IP \
		OLE\:\:Storage_Lite \
		Sys\:\:Hostname\:\:Long \
		Sys\:\:SigAction \
		Test\:\:Pod \
		IO\:\:SessionData \
		Crypt\:\:SSLeay \
		Class\:\:Inspector \
		Task\:\:Weaken \
		Mozilla\:\:CA \
		LWP\:\:Protocol\:\:https \
		Try\:\:Tiny \
		SOAP\:\:Lite \
		MT \
		XMLRPC\:\:Lite \
		Net\:\:SSLeay \
		Config\:\:Simple \
		IO\:\:AIO \
		AnyEvent\:\:AIO \
		MIME\:\:Types \
		Capture\:\:Tiny \
		Email\:\:Date\:\:Format \
		MIME\:\:Lite \
		Net\:\:SMTP\:\:SSL \
		Net\:\:Daemon \
		RPC\:\:PlClient \
		Socket6 \
		AnyEvent\:\:DNS \
		AnyEvent\:\:Socket \
		AnyEvent\:\:Util \
		FCGI \
		EV \
		Test\:\:Refcount \
		Test\:\:Fatal \
		Test\:\:Identity \
		Future \
		IO\:\:Async \
		DBIx\:\:Simple \
		Async\:\:MergePoint \
		Authen\:\:NTLM \
		Event \
		Guard \
		Socket\:\:GetAddrInfo \
		POE\:\:Test\:\:Loops \
		IO\:\:Pipely \
		IO\:\:Tty \
		POE \
		Test\:\:Base \
		Curses \
		JSON \
		Test\:\:Requires \
		Module\:\:ScanDeps \
		PAR\:\:Dist \
		File\:\:Remove \
		Module\:\:Install\:\:Base \
		Test\:\:Simple \
		YAML\:\:Tiny \
		Spiffy \
		Types\:\:Serialiser \
		JSON\:\:XS \
		Net\:\:Server\:\:PreFork \
		BSD\:\:Resource \
		Data\:\:Flow \
		IPC\:\:Run3 \
		Frontier\:\:RPC2 \
		Authen\:\:SASL \
		Net\:\:LDAP \
		WWW\:\:Curl\:\:Easy \
		Mail\:\:Sendmail \
		Authen\:\:Smb \
		Crypt\:\:PasswdMD5 \
		GSSAPI \
		Convert\:\:ASN1 \
		Error \
		HTML\:\:TreeBuilder \
		Test\:\:Script \
		File\:\:Which \
		Probe\:\:Perl \
		HTML\:\:FormatText \
		Crypt\:\:RC4 \
		Digest\:\:Perl\:\:MD5 \
		Parse\:\:RecDescent \
		Spreadsheet\:\:ParseExcel \
		Spreadsheet\:\:WriteExcel \
		HTML\:\:Form \
		HTTP\:\:Server\:\:Simple \
		WWW\:\:Mechanize \
		Jcode \
		Unicode\:\:Map \
		Locale\:\:gettext_xs \
		Mojo\:\:Base \
		Module\:\:Build \
		Object\:\:Accessor \
		CGI \
		Tk \
		Module\:\:ScanDeps \
		UV

CPAN_MODS =	Font\:\:TTF \
		XML\:\:Simple \
		Archive\:\:Zip \
		YAML \
		Term\:\:ReadKey \
		Text\:\:WrapI18N \
		Unicode\:\:LineBreak \
		File\:\:HomeDir
#		Razor2 \

all:
	git submodule update --init || true
	@echo "There is no all target run make install but i did turn on the submodules"

DBD-mysql_mod:
	git submodule update --init $(subst _mod,, $@)
	@export PERL5LIB=$(PERL5LIB); \
	cd $(subst _mod,, $@) && git clean -x -f -d && perl Makefile.PL --mysql_config=/opt/mysql/bin/mysql_config  --with-mysql=/opt/mysql --ssl --libs="-L/opt/mysql/$(LIBDIR) -lmysqlclient -lpthread -lz -lm -ldl" \
                                                                        --cflags="-I/opt/mysql/include" && make && make DESTDIR=$(PERLTMP) install && touch ../$@

Perl-Tk_mod:
	git submodule update --init $(subst _mod,, $@)
	@export PERL5LIB=$(PERL5LIB); \
	cd $(subst _mod,, $@) && git clean -x -f -d && perl Makefile.PL X11INC=/opt/Xorg/include && make && make DESTDIR=$(PERLTMP) install && touch ../$@

Mail-SpamAssassin_mod:
	git submodule update --init $(subst _mod,, $@)
	@export PERL5LIB=$(PERL5LIB); \
	cd $(subst _mod,, $@) && git clean -x -f -d && perl Makefile.PL CONTACT_ADDRESS="the administrator of that system" && make && make DESTDIR=$(PERLTMP) install && touch ../$@

DB_File_mod:
	git submodule update --init $(subst _mod,, $@)
	cd $(subst _mod,, $@) && ./config.sh $(ARCH) git clean -x -f -d && perl Makefile.PL && make && make DESTDIR=$(PERLTMP) install && touch ../$@

%_mod:
	git submodule update --init $(subst _mod,, $@)
	cd $(subst _mod,, $@) && git clean -x -f -d && perl Makefile.PL && make && make DESTDIR=$(PERLTMP) install && touch ../$@

clean_mods:
	rm -f $(CPAN_DEPENDS) $(CPAN_MODS) $(LOCMODS)
	rm -rf $(PERLTMP)

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
	install -d $(DESTDIR)/opt/bin
	ln -sr $(DESTDIR)/usr/bin/perl $(DESTDIR)/opt/bin/perl
	if [ -e $(DESTDIR)/usr/bin/mt ];then \
	  mv $(DESTDIR)/usr/bin/mt $(DESTDIR)/usr/bin/MT; \
	fi

%:
	@export PERL5LIB=$(PERL5LIB); \
	cpan -j cpan.cfg -ifT $@ && touch $@

.notparallel:
.phony: install all clean distclean clean_mods
