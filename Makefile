PRESENTATION = haskell-shell-scripting

PANDOC = pandoc

PRODUCTION = --self-contained

slidy:
	$(PANDOC) -s -t slidy -V slidy-url=. --smart -o $(PRESENTATION).html $(PRESENTATION).md

upload:
	$(PANDOC) -s -t slidy --smart -o $(PRESENTATION).html $(PRESENTATION).md
	scp $(PRESENTATION).html $(PRESENTATION).md juhp@code.haskell.org:talks/fossasia2017-haskell-shell/
