all	:
	@echo "available targets:"\
	" all1 init depends install heap-view depends-heap-view install-heap-view delete push pull"

all1	:
	$(MAKE) delete || true
	$(MAKE) init
	$(MAKE) depends
	$(MAKE) install

init	:
	cabal sandbox init

# when working with ghc >= 7.8 this is redundant
add-src	:
	cabal sandbox add-source ../bytestring		# local version of latest bytesting package
	cabal sandbox add-source ../short-bytestring	# local version of latest bytesting package
	cabal sandbox add-source ../text		# local version of latest text package
	cabal sandbox add-source ../data-size		# development version of data-source

depends	:
	cabal install --dependencies-only --force-reinstall --enable-tests

install	:
	cabal install --force-reinstall

heap-view		:
	$(MAKE) delete || true
	$(MAKE) init
	$(MAKE) depends-heap-view
	$(MAKE) install-heap-view

depends-heap-view	:
	cabal install --flags=with-heap-view --dependencies-only --force-reinstall

install-heap-view	:
	cabal install --flags=with-heap-view --force-reinstall

delete	:
	cabal sandbox delete

push	:
	git push --tags origin master

pull	:
	git pull --rebase --tags origin master

.PHONY	: all init push pull delete

