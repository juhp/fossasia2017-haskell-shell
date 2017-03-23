PRESENTATION = haskell-shell-scripting

PANDOC = pandoc

ifdef PRODUCTION
MODE = --self-contained
else
MODE = "-V slidy-url=."
endif

slidy:
	$(PANDOC) -s -t slidy $(MODE) --smart -o $(PRESENTATION).html $(PRESENTATION).md

upload:
	$(PANDOC) -s -t slidy --smart -o $(PRESENTATION).html $(PRESENTATION).md
	scp $(PRESENTATION).html $(PRESENTATION).md juhp@code.haskell.org:talks/fossasia2017-haskell-shell/
